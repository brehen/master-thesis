use std::{path::PathBuf, time::Instant};
use wasi_common::pipe::{ReadPipe, WritePipe};

use wasmtime::*;
use wasmtime_wasi::sync::WasiCtxBuilder;

/* Load Wasm binary that matches module path, execute its main
*  function and return the result. Take timestamps for defining
*  startup and total runtime for each invocation. */
fn run_wasm(
  input: &str,
  wasm_module_path: PathBuf,
  func_name: &str,
) -> Result<FunctionResult, anyhow::Error> {
  let start_since_epoch = current_micros()?;
  let start = Instant::now();
  // 1.1.
  let engine = Engine::default();
  let mut linker = Linker::new(&engine);
  // 1.2.
  wasmtime_wasi::add_to_linker(&mut linker, |s| s)?;
  let stdin = ReadPipe::from(input);
  let stdout = WritePipe::new_in_memory();
  let wasi = WasiCtxBuilder::new();
  let mut store = Store::new(&engine, wasi)
    .stdin(Box::new(stdin.clone()))
    .stdout(Box::new(stdout.clone()))
    .build();
  // 1.3.
  let module = load_module(&engine, wasi_module_path)?;
  let startup_time = start.clone().elapsed().as_micros();
  linker.module(&mut store, "", &module)?;
  // 1.4.
  linker
    .get_default(&mut store, "")?
    .typed::<(), ()>(&store)?
    .call(&mut store, ())?;
  drop(store);
  // 1.5.
  let contents: Vec<u8> = stdout
    .try_into_inner()
    .map_err(|_err| anyhow::Error::msg("sole remaining reference"))?
    .into_inner();
  let result = String::from_utf8(contents)?.trim().to_string();
  Ok(FunctionResult {
    result,
    metrics: Metrics {
      startup_time,
      start_since_epoch,
      total_runtime: start.elapsed().as_micros(),
      end_since_epoch: start_since_epoch + total_runtime,
    },
    func_type: ModuleType::Wasm,
    func_name: func_name.to_string(),
    input: input.to_string(),
  })
}

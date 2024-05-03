use std::{fs::File, io::Read, path::PathBuf};
use wasmtime::{Engine, Module};
// Read modules from file and deserialize as bytes
fn load_module(
  engine: &Engine,
  wasi_module_path: PathBuf,
) -> anyhow::Result<Module, anyhow::Error> {
  // 1.
  let mut module_file = File::open(wasi_module_path)?;
  let mut module_bytes = Vec::<u8>::new();
  // 2.
  module_file.read_to_end(&mut module_bytes)?;
  // 3.
  let module = unsafe { Module::deserialize(engine, &module_bytes)? };
  // 4.
  Ok(module)
}

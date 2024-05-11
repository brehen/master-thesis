use std::{fs::File, io::Read, path::PathBuf};
use wasmtime::{Engine, Module};
// Read modules from file and deserialize as bytes
fn load_module(
  engine: &Engine,
  wasi_module_path: PathBuf,
) -> anyhow::Result<Module, anyhow::Error> {
  let mut module_file = File::open(wasi_module_path)?;
  let mut module_bytes = Vec::<u8>::new();
  module_file.read_to_end(&mut module_bytes)?;
  let module = unsafe { Module::deserialize(engine, &module_bytes)? };
  Ok(module)
}

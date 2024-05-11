use std::{fs::File, io::Read, io::Write, path::PathBuf};
use wasmtime::{Engine, Module};
// Serialize all modules into bytecode and save as files
fn serialize_wasm_modules(
  module_dir: PathBuf,
  serialized_dir: PathBuf,
) {
  // 3.1.
  let modules = list_files(module_dir.to_str().unwrap())?;
  // 3.2.
  let engine = Engine::default();
  // 3.3.
  for module in modules {
    let module_name = module.file_name().unwrap();
    // 3.4.
    let module = Module::from_file(&engine, &module)?;
    let module_bytes = module.serialize()?;

    let target_module = serialized_dir.join(module_name);

    // 3.5.
    let mut file = std::fs::File::create(target_module)?;

    file.write_all(&module_bytes)?;
  }
}

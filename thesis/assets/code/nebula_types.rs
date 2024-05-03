enum FunctionType {
  Docker,
  Wasm,
}
struct FunctionRequest {
  function_name: String,
  input: String,
  module_type: FunctionType,
}
struct Metrics {
  startup_time: u64,
  total_runtime: u64,
  start_since_epoch: u64,
  end_since_epoch: u64,
}
struct FunctionResult {
  func_type: FunctionType,
  func_name: String,
  input: String,
  result: String,
  metrics: Metrics,
}

use std::{
  io::{Error, Result, Write},
  process::{Command, Stdio},
  time::Instant,
};
/* Spin up Docker container matching image name for
function and take timestamps for startup which
is used to determine actual startup, and total runtime */
pub fn run_docker_image(
  image_name: &str,
  input: &str,
  func_name: String,
) -> Result<FunctionResult> {
  let start_since_epoch = current_micros()?;
  let start = Instant::now();
  // 2.1.
  let mut child = Command::new("docker")
    .args(["run", "--rm", "-i", image_name])
    .stdin(Stdio::piped())
    .stdout(Stdio::piped())
    .spawn()?;
  // 2.2.
  let cmd_start = current_micros()?;
  // 2.3.
  child.stdin.as_mut().unwrap().write_all(input.as_bytes())?;
  // 2.4.
  let output = child.wait_with_output()?;
  let stdout = String::from_utf8_lossy(&output.stdout);
  // 2.5.
  let (result, actual_startup) = parse_output(&stdout, cmd_start)?;
  Ok(FunctionResult {
    result,
    metrics: Metrics {
      startup_time: actual_startup,
      total_runtime: start.elapsed().as_micros(),
      start_since_epoch,
      end_since_epoch: start_since_epoch + total_runtime,
    },
    func_type: ModuleType::Docker,
    func_name,
    input: input.to_string(),
  })
}

fn get_stdin<T: FromStr>() -> Result<T> {
  let mut input = String::new();
  // Lock process and wait for stdin to be passed in
  stdin()
    .lock()
    .read_line(&mut input)
    .context("Failed to read line")?;
  // Parse input to a String and return the value
  input.trim().parse::<T>().map_err(|_| {
    Error::msg(format!(
      "Failed to parse input as {}",
      type_name::<T>()
    ))
  })
}
// If timestamp was recorded for function, print it ot stdout
fn print_stdout<T: Display>(output: T, timestamp: Option<String>) {
  match timestamp {
    Some(timestamp) => println!("{}|{}", output, timestamp),
    None => println!("{}", output),
  }
}
pub fn run_function<T, F, R>(func: F, func_type: FunctionType)
where
  T: FromStr,
  F: Fn(T) -> R,
  R: std::fmt::Display,
{
  // If function is Docker, get timestap, else if Wasm it is of type "None"
  let timestamp = match func_type {
    FunctionType::Docker => docker::get_epoch_timestamp(),
    FunctionType::Wasm => wasm::get_epoch_timestamp(),
  };
  // Read from input
  let input: T = get_stdin().expect("To parse correctly");
  // Call function with input and receive result
  let result = func(input);
  // Print input to stdout, with timestamp if func_type was Docker
  print_stdout(result, timestamp)
}

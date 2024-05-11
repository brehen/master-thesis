async fn stress_nebula(
  client: Client,
  url: &str,
) -> anyhow::Result<Vec<FunctionResult>> {
  // 4.1. function name, how many requests, steps
  let functions: Vec<(&str, u32, u32)> = vec![
    ("exponential", 353, 2),
    ("factorial", 130, 1),
    ("fibonacci-recursive", 40, 1),
    ("prime-number", 600, 10),
  ];
  let mut function_results: Vec<FunctionResult> = Vec::new();
  // 4.2.
  for function in functions {
    // 4.3.
    for input_value in 0..=function.1 {
      // 4.4.
      let input_value = input_value * function.2;
      // 4.5.
      for _ in 0..6 {
        // 4.6.
        let wasm_results = make_request(
          &client, url, function.0,
          "Wasm", &input_value.to_string()
        ).await?;
        function_results.extend(wasm_results);
        let docker_results = make_request(
          &client, url, function.0,
          "Docker", &input_value.to_string(),
        ).await?;
        function_results.extend(docker_results);
      }
    }
  }
  // 4.7.
  Ok(function_results)
}

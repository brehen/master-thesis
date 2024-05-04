use reqwest::Client;
pub async fn benchmark_nebula_rpi(fill_in_gaps: bool) {
  // 1.
  let client = Client::new();
  let mut results: Vec<FunctionResult> = vec![];
  let mut sensor_readings: Vec<SensorData> = vec![];

  // 2.
  let mut stress_nebula_handle = tokio::spawn(async move {
    stress_nebula(client, "http://192.168.68.69/api/wasm_headless")
      .await
      .unwrap()
  });
  // 3.
  loop {
    // 4.
    tokio::select! {
        // 5.
        result = &mut bombard_handle => {
            results.extend(result.unwrap());
            break;
        }
        // 6.
        data = read_modbus_data("192.168.68.66:502") => {
            sensor_readings.push(data.unwrap());
        }
    }
  }
}

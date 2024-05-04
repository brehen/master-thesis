pub fn associate_power_measurements(
  mut function_results: Vec<FunctionResult>,
  sensor_data: &Vec<SensorData>,
) -> Vec<FunctionResult> {
  // 1.
  let mut processed_results = Vec::new();
  let microseconds_to_hour = 1000.0 * 1000.0 * 60.0 * 60.0;
  // 2.
  for mut function_result in function_results {
    // 3.
    let function_start_time =
      function_result.metrics.start_since_epoch;
    let function_end_time = function_result.metrics.end_since_epoch;
    let mut total_power = 0.0;
    let mut num_readings = 0;
    // 4.
    for data in sensor_data {
      if data.start_read >= function_start_time
        && data.end_read < function_end_time
      {
        total_power += data.power;
        num_readings += 1;
      }
    }
    // 5.
    if num_readings > 0 {
      let avg_power = total_power / num_readings as f32;
      let duration = function_end_time - function_start_time;
      let energy_consumption_wh =
        (avg_power * duration as f32) / microseconds_to_hour;

      function_result.metrics.average_power = avg_power;
      function_result.metrics.energy_consumption_wh =
        energy_consumption_wh;
      processed_results.push(function_result);
    }
  }

  processed_results
}

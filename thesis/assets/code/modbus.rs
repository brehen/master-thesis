use serde_derive::{Deserialize, Serialize};
use tokio_modbus::prelude::*;
// Start tcp client that connects to Gude controller and 
// reads sensor values over register addresses in tcp packets
pub async fn read_modbus_data(
  addr: &str,
) -> Result<SensorData, anyhow::Error> {
  // 5.1.
  let mut client = tcp::connect("192.168.68.70:502".parse()?).await?;
  let start_read = current_micros()?;
  // 5.2.
  let current_register = client
      .read_input_registers(LineInEnergySensor::Current as u16, 2)
      .await?;
  let raw_current = 
    (i32::from(current_register[0]) << 16) | i32::from(current_register[1]);
  let current = (raw_current as f32) / 1000.0;
  // 5.3.
  let power_factor_register = client
      .read_input_registers(LineInEnergySensor::PowerFactor as u16, 2)
      .await?;
  let raw_power_factor =
      (i32::from(power_factor_register[0]) << 16) |
      i32::from(power_factor_register[1]);
  let power_factor = (raw_power_factor as f32) / 1000.0;
  // 5.4.
  let power = 240.0 * current * power_factor;
  let end_read = current_micros()?;
  Ok(SensorData { power, start_read, end_rad })
}

#[derive(Serialize, Deserialize)]
pub struct SensorData {
  pub power: f32,
  pub start_read: u128,
  pub end_read: u128,
}

pub enum LineInEnergySensor {
  Current = 0x406,
  PowerFactor = 0x40a,
}


// Include crates
use axum::{routing::post, Router};
use std::net::{IpAddr, Ipv4Addr, SocketAddr};
use tokio::net::TcpListener;
// Supporting library for our function execution
use nebula_server::api::call_function::call_function;
// Entry point, Tokio main function
#[tokio::main]
async fn main() {
  let router =
    Router::new().route("/invoke_function", post(call_function));
  // Precompile and serialize our Wasm modules, more on that later.
  serialize_modules();
  let localhost = IpAddr::V4(Ipv4Addr::new(127, 0, 0, 1));
  let listener = TcpListener::bind(&SocketAddr::new(localhost, 3090))
    .await
    .unwrap();

  axum::serve(listener, router.into_make_service()).await?;
}

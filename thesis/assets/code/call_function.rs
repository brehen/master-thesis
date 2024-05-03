use axum::{http::StatusCode, response::IntoResponse, Form};
use nebula_lib::{docker_runner::run_docker, wasm_runner::run_wasm};
use serde::Serialize;
// Define response body, that can be serialized to JSON
#[derive(Serialize)]
struct Response {
  result: FunctionResult,
}
// Call function that takes the request as a form and invoke the correct type
async fn call_function(
  Form(request): Form<FunctionRequest>,
) -> impl IntoResponse {
  let result: FunctionResult = match request.function_type {
    FunctionType::Docker => {
      let docker_function = format!(
        "nebula-function-{}-{}",
        request.function_name, request.base_image
      );
      run_docker(
        &docker_function,
        &request.input,
        request.function_name,
        request.base_image,
      )
      .unwrap()
    }
    FunctionType::Wasm => {
      let function_path = get_file_path(&request.function_name);
      run_wasm(&request.input, function_path, &request.function_name)
        .unwrap()
    }
  };

  let body = serde_json::to_string(&Response { result }).unwrap();

  return (StatusCode::OK, body).into_response();
}

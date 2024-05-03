# Example 1
#!/bin/sh
/usr/local/bin/<function_name>

# Example 2
cargo new example_function
# Implement example function in ./example_function/src/main.rs
make build_wasm build_docker
make deploy_wasm deploy_docker

# Example 3
sudo apt update
sudo apt full-upgrade

# Example 4
# Raspberry Pi arm target
cargo build --release --target arm-unknown-linux-gnueabi
# NREC virtual machine target
cargo build --release --target x86_64-unknown-linux-gnu

FROM rust:1.70 as build
WORKDIR /usr/src/nebula
# Copy shared library into layer
COPY shared /usr/src/shared
# Expose function name (folder) as an argument for Docker
ARG PROGRAM_NAME
COPY $PROGRAM_NAME .
# Build release binary with timestamp 
RUN cargo build --release --features docker 
# Target smaller release docker image 
FROM debian:bullseye-slim
# Install required libraries/dependencies and update
RUN apt-get update && \
    apt-get install -y libc6 && \
    rm -rf /var/lib/apt/lists/* ;\
# Copy over rust binary, and a custom run.sh script
COPY --from=build /usr/src/nebula/target/release/$PROGRAM_NAME /usr/local/bin/
COPY --from=build /usr/src/nebula/run.sh /usr/local/bin/
# When container is invoked, run this shell command
CMD ["run.sh"]

cargo build --release
strip target/release/libhttpserver.so
strip target/release/httpserver
cp target/release/libhttpserver.so .

cargo build --release
strip target/release/libhttpserver.so
cp target/release/libhttpserver.so .
capstan package compose -v rust-osv

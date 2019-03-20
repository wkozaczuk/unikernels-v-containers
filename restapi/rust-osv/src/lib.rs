#[macro_use]
extern crate lazy_static;
mod rest;

#[no_mangle]
pub extern fn main() {
    rest::start_server();
}

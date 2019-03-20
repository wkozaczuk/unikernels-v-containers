#[macro_use]
extern crate lazy_static;
mod rest;

fn main() {
    rest::start_server();
}

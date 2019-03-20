#![deny(warnings)]
extern crate regex;
extern crate futures;
extern crate hyper;
extern crate pretty_env_logger;
extern crate serde;
extern crate serde_json;

use self::futures::future;

use self::hyper::{Body, Method, Request, Response, Server, StatusCode, header};
use self::hyper::rt::{self, Future};
use self::hyper::service::service_fn;

use self::regex::Regex;

#[derive(Debug, serde_derive::Serialize)]
struct Todo<'a> {
    name: &'a str
}

const NOTFOUND: &[u8] = b"Not Found";
const WELCOME: &'static str = "Welcome from Rust on OSv!";

fn build_json_response(json: String) 
    -> Response<Body>
{
    Response::builder()
        .header(header::CONTENT_TYPE, "application/json")
        .body(Body::from(json))
        .unwrap()
}

fn api_responses(req: Request<Body>, todos: &Vec<Todo>)
    -> Box<Future<Item=Response<Body>, Error=hyper::Error> + Send>
{
    match (req.method(), req.uri().path()) {
        (&Method::GET, "/") => {
            let body = Body::from(WELCOME);
            Box::new(future::ok(Response::new(body)))
        },
        (&Method::GET, "/todos") => {
            let json = serde_json::to_string(&todos).unwrap();
            Box::new(future::ok(build_json_response(json)))
        }
        (_,path) => {
            lazy_static! {
                static ref RE: Regex = Regex::new(r"/todos/(\d+)").unwrap();
            }
            let caps = RE.captures(path);
            match caps.map(|c| c.get(1).map(|s| s.as_str().parse::<usize>())) {
                Some(Some(Ok(id))) if id < todos.len() => {
                    let json = serde_json::to_string(&todos[id]).unwrap();
                    Box::new(future::ok(build_json_response(json)))
                }
                _ => {
                    // Return 404 not found response.
                    let body = Body::from(NOTFOUND);
                    Box::new(future::ok(Response::builder()
                                                 .status(StatusCode::NOT_FOUND)
                                                 .body(body)
                                                 .unwrap()))
                }
            }
        }
    }
}

pub fn start_server() {
    pretty_env_logger::init();

    let service = move || { 
        let todos = vec![
            Todo{name:"Write presentation"},
            Todo{name:"Host meetup"},
            Todo{name:"Run tests"},
            Todo{name: "Stand in traffic"},
            Todo{name: "Learn Rust"}];

        service_fn(move |req| {
            api_responses(req, &todos)
        })
    };

    let addr = ([0, 0, 0, 0], 3000).into();

    let server = Server::bind(&addr)
        .serve(service)
        .map_err(|e| eprintln!("server error: {}", e));

    println!("Listening on http://{}", addr);

    rt::run(server);
}

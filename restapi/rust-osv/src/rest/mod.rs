#![deny(warnings)]
extern crate regex;
extern crate futures;
extern crate hyper;
extern crate pretty_env_logger;
extern crate serde;
extern crate serde_json;
extern crate num_cpus;
extern crate chrono;

use self::futures::future;

use self::hyper::{Body, Method, Request, Response, Server, StatusCode, header};
use self::hyper::rt::{self, Future};
use self::hyper::service::service_fn;
use self::chrono::{DateTime, Local};

use self::regex::Regex;

#[derive(Debug, serde_derive::Serialize)]
struct Todo<'a> {
    name: &'a str,
    completed: bool,
    due: DateTime<Local>
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
            match RE.captures(path).
                and_then(|c| c.get(1).
                map(|s| s.as_str().parse::<usize>())) {
                    Some(Ok(id)) if id < todos.len() => {
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
            Todo{name:"Write presentation", completed:false, due:Local::now()},
            Todo{name:"Host meetup", completed:false, due:Local::now()},
            Todo{name:"Run tests", completed:false, due:Local::now()},
            Todo{name:"Stand in traffic", completed:false, due:Local::now()},
            Todo{name:"Learn Rust", completed:false, due:Local::now()}];

        service_fn(move |req| {
            api_responses(req, &todos)
        })
    };

    let addr = ([0, 0, 0, 0], 8080).into();

    let server = Server::bind(&addr)
        .serve(service)
        .map_err(|e| eprintln!("server error: {}", e));

    println!("Detected {} CPUs", num_cpus::get());
    println!("Rust listening on port 8080");

    rt::run(server);
}

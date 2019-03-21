FROM ubuntu:18.10

WORKDIR /app

ADD ./target/release/httpserver /app

EXPOSE 8080

CMD ["/app/httpserver"]

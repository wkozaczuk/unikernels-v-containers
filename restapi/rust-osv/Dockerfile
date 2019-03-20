FROM scratch

WORKDIR /app

ADD ./target/release/httpserver /app

EXPOSE 80

CMD ["/app/rest"]

go build -buildmode=pie -o rest
docker build . -t tg/go-rest-pie

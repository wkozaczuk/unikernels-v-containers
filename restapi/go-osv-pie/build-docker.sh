go build -buildmode=pie -o rest
docker build . -t tg/go-rest-pie
docker save -o ../container/go-rest-pie.tar tg/go-rest-pie

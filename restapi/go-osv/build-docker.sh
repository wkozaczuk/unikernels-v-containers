CGO_ENABLED=0 GOOS=linux go build -a -o restapi *.go
#docker build . -t tg/go-exe

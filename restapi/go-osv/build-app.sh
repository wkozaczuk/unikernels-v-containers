GOOS=linux go build -buildmode=c-shared -o restapi.so CMain.go Handlers.go Routes.go Todo.go
strip restapi.so
CGO_ENABLED=0 GOOS=linux go build -a -o restapi Main.go Handlers.go Routes.go Todo.go
strip restapi

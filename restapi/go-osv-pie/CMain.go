package main

import (
    "log"
    "net/http"
    "C"
    "fmt"
)

func main() {
}

//export GoMain
func GoMain() {
    router := NewRouter()
    fmt.Println("Listening on port 8080");
    log.Fatal(http.ListenAndServe(":8080", router))
}

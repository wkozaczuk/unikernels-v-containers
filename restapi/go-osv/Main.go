package main

import (
    "log"
    "net/http"
    "fmt"
)

func main() {
    router := NewRouter()
    fmt.Println("Listening on port 8080");
    log.Fatal(http.ListenAndServe(":8080", router))
}

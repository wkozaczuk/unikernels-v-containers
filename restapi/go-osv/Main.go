package main

import (
    "log"
    "net/http"
    "fmt"
    "runtime"
)

func main() {
    router := NewRouter()
    fmt.Printf("Detected %d CPUs\n", runtime.NumCPU());
    fmt.Println("Listening on port 8080");
    log.Fatal(http.ListenAndServe(":8080", router))
}

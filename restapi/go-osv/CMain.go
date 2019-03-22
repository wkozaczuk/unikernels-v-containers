package main

import (
    "log"
    "net/http"
    "C"
    "fmt"
    "runtime"
)

func main() {
}

//export GoMain
func GoMain() {
    router := NewRouter()
    fmt.Printf("Detected %d CPUs\n", runtime.NumCPU());
    fmt.Println("Go listening on port 8080");
    log.Fatal(http.ListenAndServe(":8080", router))
}

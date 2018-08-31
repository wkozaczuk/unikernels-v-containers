package main

import (
    "log"
    "net/http"
    "C"
)

func main() {
}

//export GoMain
func GoMain() {
    router := NewRouter()
    log.Fatal(http.ListenAndServe(":8080", router))
}

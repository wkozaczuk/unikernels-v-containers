package main

import (
	"C"
	"log"
	"net/http"
)

func main() {
	//router := NewRouter()
	//log.Fatal(http.ListenAndServe(":8080", router))
}

//export GoMain
func GoMain() {
	router := NewRouter()
	log.Fatal(http.ListenAndServe(":8080", router))
}

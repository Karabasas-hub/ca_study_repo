package main

import (
	"fmt"
	"log"
	"net/http"
)

func homePage(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Welcome to the HomePage")
}

func aboutPage(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "About Page")
}

func handleRequests() {
	http.HandleFunc("/", homePage)
	http.HandleFunc("/about", aboutPage)
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func main() {
	handleRequests()
}

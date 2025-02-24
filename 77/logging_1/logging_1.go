package main

import (
	"log"
	"time"
)

const (
	YYYYMMDD  = "2006-01-03"
	HHMMSS12h = "3:04:05 PM"
)

func main() {
	flags := log.Lshortfile
	datetime := time.Now().UTC().Format(YYYYMMDD+" "+HHMMSS12h) + ": "
	log.Println("Without log levels")
	log.SetFlags(flags)
	log.SetPrefix("INFO: " + datetime)
	log.Println("INFO level")
	log.SetPrefix("WARN: " + datetime)
	log.Println("WARN level")
	log.SetPrefix("DEBUG: " + datetime)
	log.Println("DEBUG level")
	log.SetPrefix("ERROR: " + datetime)
	log.Println("ERROR level")
	log.SetPrefix("FATAL: " + datetime)
	log.Println("FATAL level")
}

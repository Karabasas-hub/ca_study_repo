package main

import (
	"log"
	"os"
	"time"
)

const (
	YYYYMMDD  = "2006-01-02"
	HHMMSS12h = "3:04:05 PM"
)

func main() {
	flags := log.Lshortfile
	datetime := time.Now().UTC().Format(YYYYMMDD+" "+HHMMSS12h) + ": "
	file, err := os.OpenFile("logs.log", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		logger := log.New(file, "", flags)
		logger.SetPrefix("FATAL: " + datetime)
		logger.Println(err)
	}

	defer file.Close()
	logger := log.New(file, "", flags)
	logger.SetPrefix("INFO: " + datetime)
	logger.Println("Log custom date and time in a logs.log file")
}

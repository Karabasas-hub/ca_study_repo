package main

import (
	"fmt"
	"os"

	log "github.com/sirupsen/logrus"
)

func main() {
	logFile := "log.txt"
	f, err := os.OpenFile(logFile, os.O_WRONLY|os.O_CREATE|os.O_APPEND, 0644)
	if err != nil {
		fmt.Println("Failed to create logfile" + logFile)
		panic(err)
	}

	defer f.Close()
	log.SetOutput(f)
	log.SetLevel(log.DebugLevel)
	log.Info("Info message")
}

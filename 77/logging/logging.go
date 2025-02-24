package main

import "log"

const (
	Ldate = iota
	Ltime
	Lmicroseconds
	Llongfile
	Lshortfile
	LUTC
	Lmsgprefix
	LstdFlags = Ldate | Ltime
)

func main() {
	log.Println("Default log message")
	log.SetFlags(log.Ldate)
	log.Println("Log to the console with date prepended")
	log.SetFlags(log.Ltime)
	log.Println("Log to the console with time prepended")
	log.SetFlags(log.Ldate | log.Ltime)
	log.Println("Log to the console with date and time prepended")
	log.SetFlags(log.Lshortfile)
	log.Println("Log to the console with filename prepended")
	log.SetFlags(log.LstdFlags | log.Lshortfile)
	log.Println("Log to the console with date, time and filename prepended")
}

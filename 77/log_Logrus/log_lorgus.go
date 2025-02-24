package main

import (
	"github.com/sirupsen/logrus"
)

func main() {
	logrus.SetLevel(logrus.TraceLevel)
	logrus.Traceln("Trace level")
	logrus.Debugln("Debug level")
	logrus.Infoln("Info level")
	logrus.Warningln("Warning level")
	logrus.Errorln("Error level")
	logrus.Fatalln("Fatal level")
	logrus.Panicln("Panic level")
}

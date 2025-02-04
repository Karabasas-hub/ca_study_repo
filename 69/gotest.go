package main

import "fmt"

func main()  {
	fmt.Println("Hello, World")
	
	var print int

	print = second(1, 2.0)

	fmt.Println(print)

	const a = 2
	const b = "this is a string"
	const c = 2.5

	fmt.Println(a, b, c)
	fmt.Println("2 / 2.5 = ", float64(a)/c)

	var pirmas string = "I"
	var antras = "can"
	var trecias = "go"
	var ketvirtas = "home"
	var penktas = pirmas + " " + antras + " " + trecias + " " + ketvirtas
	fmt.Println(pirmas, " + ", antras, " + ", trecias, " + ", ketvirtas, " -> ", penktas) 
}


func second(first int, second float32) int{
	return first + 1 + int(second)
}
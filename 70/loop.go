package main

import (
	"fmt"
	//"time"
	//"slices"
)

func main() {
	/**
			if 7%2 == 0 {
				fmt.Println("7 is even")
			} else {
				fmt.Println("7 is odd")
			}

			if 8%4 == 0 {
				fmt.Println("8 is divisable by 4")
			}

			if 8%2 == 0 || 7%2 == 0 {
				fmt.Println("either 8 or 7 is even")
			}

			if num := 9; num < 0 {
				fmt.Println(num, "is negative")
			} else if num < 10 {
				fmt.Println(num, "has 1 digit")
			} else {
				fmt.Println(num, "has multiple digits")
			}

		i := 2
		fmt.Println("Write", i, "as ")
		switch i {
		case 1:
			fmt.Println("one")
		case 2:
			fmt.Println("two")
		}

		switch time.Now().Weekday() {
		case time.Saturday, time.Sunday:
			fmt.Println("Its the weekend")
		default:
			fmt.Println("Its a weekday")
		}

		whatAmI := func(i interface{}) {
			switch t := i.(type) {
			case bool:
				fmt.Println("I am a bool")
			case int:
				fmt.Println("Im an int")
			default:
				fmt.Println("Dont know type %T\n", t)
			}
		}

		whatAmI(true)
		whatAmI(1)
		whatAmI("hey")


	var s []string
	fmt.Println("uninit:", s, s == nil, len(s) == 0)

	s = make([]string, 3)
	fmt.Println("emp:", s, "len:", len(s), "cap:", cap(s))

	s[0] = "a"
	s[1] = "b"
	s[2] = "c"
	fmt.Println("set:", s)
	fmt.Println("get:", s[2])


	var s []string
	s = make([]string, 3)
	s[0] = "a"
	s[1] = "b"
	s[2] = "c"
	fmt.Println("len:", len(s))

	s = append(s, "d")
	s = append(s, "e", "f")
	fmt.Println("apd:", s)

	c := make([]string, len(s))
	copy(c, s)
	fmt.Println("cpy:", c)

	l := s[2:5]
	fmt.Println("sl1:", l)


	s := []string{"a", "b", "c", "d", "e", "f"}

	l := s[:5]
	fmt.Println("sl2:", l)

	l = s[2:]
	fmt.Println("sl3:", l)

	t := []string{"g", "h", "i"}
	fmt.Println("dcl:", t)

	t2 := []string{"g", "h", "i"}
	if slices.Equal(t, t2) {
		fmt.Println("t == t2")
	}

	twoD := make([][]int, 3)
	for i := 0; i < 3; i++ {
		innerLen := i + 1
		twoD[i] = make([]int, innerLen)
		for j := 0; j < innerLen; j++ {
			twoD[i][j] = i + j
		}
	}
	fmt.Println("2d:", twoD)
	/**/

	i := 1
	for i <= 3 {
		fmt.Println("i:", i)
		i = i + 1
	}

	for j := 0; j < 3; j++ {
		fmt.Println("j:", j)
	}

	for i := range 3 {
		fmt.Println("range", i)
	}

	for {
		fmt.Println("loop")
		break
	}

	for n := range 6 {
		if n%2 == 0 {
			continue
		}
		fmt.Println(n)
	}
}

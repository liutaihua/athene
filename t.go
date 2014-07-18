package main

import (
	"fmt"
)

var ch chan int = make(chan int)
func xrange() chan int {
	go func() {
		for i := 2; ; i++ {
			fmt.Printf("xrange about to send %d\n", i)
			ch <- i
		}
	}()
	return ch
}

func filter(in chan int, number int) chan int {
	out := make(chan int)
	go func() {
		for {
			i := <-in
			fmt.Printf("filter%d received %d\n", number, i)
			if i%number != 0 {
				out <- i
			}
		}
	}()
	fmt.Println(out)
	fmt.Println(in)
	return out
}

func main() {
	nums := xrange()
	number := <-nums
	for number <= 20 {
		fmt.Println(number)
		nums = filter(nums, number)
		number = <-nums
		fmt.Printf("end received %d\n", number)
	}
}

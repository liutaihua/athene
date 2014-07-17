package main

import (
    "fmt"
//    "runtime"
)

func xrange() chan int{
    var ch chan int = make(chan int)
    go func() {
        for i := 2; ; i++ {
	    ch <- i
	}
    }()
    return ch
}

func compute(in chan int, number int) chan int {
    out := make(chan int)
    go func() {
        for {
	    i := <-in
	    fmt.Println(11111111111, i, number)
	    if i%number != 0 {
	        out <- i
	    }
	}
    }()
    return out
}

func main() {
    nums := xrange()
    number := <-nums
    for number <= 20 {
        fmt.Println(number)
	nums = compute(nums, number)
	number = <-nums
    }
}

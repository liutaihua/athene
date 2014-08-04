package main

import (
    "fmt"
    "time"
)

func produce(all int, ch chan int) {
    defer close(ch)
    for i := 1; i <= all; i++ {
        ch <- i
	fmt.Println(len(ch))
    }
}

func consumer(ch chan int) {
    for msg := range ch {
        fmt.Printf("sell %d\n", msg)
        csum += 1
    }
    //for {
    //    res, e := <-ch
    //    if !e {
    //        break
    //    }
    //    fmt.Printf("sell %d\n", res)
    //    csum += 1
    //}

}

var csum, vipsum = 0, 0

func main() {
    all := 100000
    ch := make(chan int, all)
    go produce(all, ch)
    for i := 2; i > 0; i-- {
        fmt.Printf("remain %d \n", i)
        time.Sleep(time.Second)
    }
    begin := time.Now()
    go consumer(ch)
    for {
        v, ok := <-ch
        if !ok {
            break
        }
        fmt.Printf("VIP: sell %d\n", v)
        vipsum += 1
    }
    time.Sleep(time.Second)
    end := time.Now()
    t := end.Sub(begin)
    fmt.Printf("Sorry %s \n", t)
    fmt.Println("start", begin)
    fmt.Println("end", end)
    fmt.Printf("total %d\n", csum+vipsum)
    fmt.Printf("custom %d\n", csum)
    fmt.Printf("VIP %d\n", vipsum)
}


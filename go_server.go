package main

import (
    "os"
    "net"
    "fmt"
    "bufio"
    "strings"
    "strconv"
    "./common"
)


func tcpServer(port int) {
    var addr = "0.0.0.0:" + strconv.Itoa(port)
    listener, err := net.Listen("tcp", addr)
    fmt.Println("start listen:", addr)
    if err != nil {
        fmt.Println("error listen: %s", err)
        os.Exit(1)
    }
    for {
        conn, err := listener.Accept()
        if err != nil {
            fmt.Println("error happend")
            continue
        }
        go app(conn)
    }
}

func app(conn net.Conn) {
    defer conn.Close()
    defer func() {
        if err := recover(); err != nil {
	    fmt.Println(err)
	}
    }()
    for {
        reader := bufio.NewReader(conn)
        data, isPrefix, err := reader.ReadLine()
        if isPrefix || err != nil {
            fmt.Println("error conn.Read or isPrefix", err)
            return
        }
        msg := string(data)
	category_and_line := strings.SplitN(msg, " ", 2)
	if len(category_and_line) < 2 {
	    return
	}
        category := category_and_line[0]
        line := category_and_line[1]
        fmt.Println(msg)

        if strings.Count(line, "profile=") > 0 || strings.Count(line, "fps:") > 0 || strings.Count(line, "[flash]") > 0 {
            //fmt.Println("profile/save || msg/diagnostic  SKIP")
            return
        }
	mysqlClient := common.GetMySQL()
	defer mysqlClient.Close()
        argsMap := common.StrToMap(line)
	var tableName string
        switch category {
            case "[hades_req]":
		tableName = "behavior_log"
            case "[profile_attr]":
		tableName = "attr_log"
		attr := common.GetValMap(argsMap, "attr")
		if common.IsStringInSlice(attr, []string{"attr_6", "token"}) {
                    common.InsertToMySQL(mysqlClient, "token_and_coupons_log", argsMap)
		}
            case "[quest]":
		tableName = "quest"
            case "[package]":
		tableName = "package"
        }
	if tableName != "" {
            common.InsertToMySQL(mysqlClient, tableName, argsMap)
	} else {
	    fmt.Println("not found corresponding db table")
	}
	fmt.Println("done")
    }
}

func main() {
	tcpServer(8888)
}

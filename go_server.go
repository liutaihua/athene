/*
author: liutaihua  defage@gmail.com
*/
package main

import (
    "os"
    "net"
    "fmt"
    "bufio"
    "strings"
    "strconv"
    "database/sql"
    "github.com/liutaihua/athene/common"
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
    reader := bufio.NewReader(conn)
    for {
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
	//mysqlClient := common.GetDBConn()
        argsMap := common.StrToMap(line)
	userid := common.GetValMap(argsMap, "userid")
        int_userid, err := strconv.Atoi(userid)
        if int_userid == 0 || err != nil {
            fmt.Println("fuckkkkkkk userid error", userid)
            fmt.Println("kkkkkkkkkkkkk ", argsMap)
            return
        }
	channel_id := (int_userid >> 16) >> 34
	db := platform_db_map[channel_id]

	var tableName string
        switch category {
            case "[hades_req]":
		tableName = "behavior_log"
            case "[profile_attr]":
		tableName = "attr_log"
		attr := common.GetValMap(argsMap, "attr")
		if common.IsStringInSlice(attr, []string{"attr_6", "token"}) {
                    common.InsertToMySQL(db, "token_and_coupons_log", argsMap)
		}
            case "[quest]":
		tableName = "quest"
            case "[package]":
		tableName = "package"
        }
	if tableName != "" {
            common.InsertToMySQL(db, tableName, argsMap)
	} else {
	    fmt.Println("not found corresponding db table")
	}
	fmt.Println("done")
    }
}


var db *sql.DB
var err error

func GetDBConn(dbName string) *sql.DB {
    user := "terminus"
    passwd := "daydayup"
    //dbName := "athene"
    //connArgs := user + ":" + passwd + "@/" + dbName + "?charset=utf8"
    connArgs := user + ":" + passwd + "@unix(/tmp/mysql.sock)/" + dbName + "?charset=utf8"
    db, err = sql.Open("mysql", connArgs)
    err = db.Ping()
    if err != nil {
        fmt.Println("connect to mysql failed")
	panic(err)
    }
    db.SetMaxIdleConns(100)
    return db
}

var platform_db_map = map[int]*sql.DB{
    1: GetDBConn("xd_athene"),
    2: GetDBConn("xunlei_athene"),
    3: GetDBConn("yygame_athene"),
    4: GetDBConn("xm_athene"),
    7: GetDBConn("ruofeng_athene"),
    8: GetDBConn("jy_athene"),
    9: GetDBConn("qixiaodidan_athene"),
    10: GetDBConn("fenghuang_athene"),
}

func main() {
    //db := common.GetMySQL()
//    db := GetDBConn()
//    db.SetMaxIdleConns(100)
//    defer db.Close()
    tcpServer(8887)
}

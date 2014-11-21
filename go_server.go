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
    "runtime"
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
	    continue
	}
        category := category_and_line[0]
        line := category_and_line[1]
        //fmt.Println(msg)

        if strings.Count(line, "profile=") > 0 || strings.Count(line, "fps:") > 0 || strings.Count(line, "[flash]") > 0  || strings.Count(line, "[equipment_destory]") > 0 {
            //fmt.Println("profile/save || msg/diagnostic  SKIP")
	    continue
        }
	//mysqlClient := common.GetDBConn()
        argsMap := common.StrToMap(line)
	userid := common.GetValMap(argsMap, "userid")
        int_userid, err := strconv.Atoi(userid)
        if int_userid == 0 || err != nil {
            fmt.Println("not found userid skip:", argsMap)
	    continue
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
                    //go common.InsertToMySQL(db, "token_and_coupons_log", argsMap)
                    common.InsertToMySQL(db, "token_and_coupons_log", argsMap)
		}
            case "[quest]":
		tableName = "quest"
            case "[package]":
		tableName = "package"
        }
	if tableName != "" {
            //go common.InsertToMySQL(db, tableName, argsMap)
            common.InsertToMySQL(db, tableName, argsMap)
	} else {
	    fmt.Println("not found corresponding db table")
	}
	//fmt.Println("done")
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
    5: GetDBConn("hfcs1_athene"),
    7: GetDBConn("ruofeng_athene"),
    8: GetDBConn("jy_athene"),
    9: GetDBConn("qixiaodidan_athene"),
    10: GetDBConn("fenghuang_athene"),
    11: GetDBConn("wyx_athene"),
    12: GetDBConn("sogou_athene"),
    13: GetDBConn("pptv_athene"),
    14: GetDBConn("baomihua_athene"),
    15: GetDBConn("vg_athene"),
    16: GetDBConn("qidian_athene"),
    17: GetDBConn("qingyou_athene"),
    18: GetDBConn("xiaozhi_athene"),
    19: GetDBConn("xiaomo_athene"),
    20: GetDBConn("miss_athene"),
    21: GetDBConn("dahei_athene"),
    22: GetDBConn("tootv_athene"),
    23: GetDBConn("37wan_athene"),
    24: GetDBConn("2144_athene"),
    25: GetDBConn("233_athene"),
    26: GetDBConn("yfly_athene"),
    27: GetDBConn("7k7k_athene"),
    28: GetDBConn("aoyou_athene"),
    29: GetDBConn("pps_athene"),
    30: GetDBConn("49you_athene"),
    31: GetDBConn("v1_athene"),
    32: GetDBConn("changyou_athene"),
    33: GetDBConn("qixing_athene"),
    34: GetDBConn("baidu_athene"),
    35: GetDBConn("kaixin_athene"),
    36: GetDBConn("2133_athene"),
    37: GetDBConn("gtv_athene"),
    38: GetDBConn("kuwo_athene"),
    39: GetDBConn("178_athene"),
    40: GetDBConn("gamefy_athene"),
    41: GetDBConn("zongheng_athene"),
    42: GetDBConn("51wan_athene"),
    43: GetDBConn("rising_athene"),
    44: GetDBConn("kugou_athene"),
    45: GetDBConn("liebao_athene"),
    46: GetDBConn("plu_athene"),
    47: GetDBConn("sinxiaozhi_athene"),
    48: GetDBConn("swjoy_athene"),
    49: GetDBConn("gaylon_athene"),
    50: GetDBConn("shijijiayuan_athene"),
    51: GetDBConn("511wan_athene"),
    52: GetDBConn("hdys_athene"),
    53: GetDBConn("letv_athene"),
}

func main() {
    //db := common.GetMySQL()
//    db := GetDBConn()
//    db.SetMaxIdleConns(100)
//    defer db.Close()
    runtime.GOMAXPROCS(4)
    tcpServer(8888)
}

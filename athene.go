/*
author: liutaihua  defage@gmail.com
*/
package main

import (
	"bufio"
	"database/sql"
	"encoding/json"
	"fmt"
	"github.com/liutaihua/athene/common"
	"io/ioutil"
	"net"
	"os"
	"runtime"
	"strconv"
	"strings"
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
		go handler(conn)
	}
}

func handler(conn net.Conn) {
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

		if strings.Count(line, "profile=") > 0 || strings.Count(line, "fps:") > 0 || strings.Count(line, "[flash]") > 0 || strings.Count(line, "[equipment_destory]") > 0 {
			//fmt.Println("profile/save || msg/diagnostic  SKIP")
			continue
		}
		argsMap := common.StrToMap(line)
		userid := common.GetValMap(argsMap, "userid")
		int_userid, err := strconv.Atoi(userid)
		if int_userid == 0 || err != nil {
			fmt.Println("not found userid skip:", argsMap)
			continue
		}
		channel_id := strconv.Itoa((int_userid >> 16) >> 34)
		//db := platform_db_map[channel_id]
		db, _ := getDB(channel_id)

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

func getDB(channelid string) (db *sql.DB, err error) {
	if platform_db_map == nil {
		dbName, is_ok := cfg[channelid].(string)
		if !is_ok {
			panic("not found channelid")
		}
		db = GetDBConn(dbName)
		platform_db_map[channelid] = db
		return db, nil
	}
	db, is_ok := platform_db_map[channelid]
	if !is_ok {
		dbName, is_ok := cfg[channelid].(string)
		if !is_ok {
			panic("not found channelid")
		}
		db = GetDBConn(dbName)
		platform_db_map[channelid] = db
	}
	return db, nil
}

func loadConfig() (cfg map[string]interface{}, err error) {
	byt, _ := ioutil.ReadFile("./config.json")
	err = json.Unmarshal(byt, &cfg)
	return
}

var platform_db_map = map[string]*sql.DB{}
var cfg map[string]interface{}

func main() {
	var err error
	cfg, err = loadConfig()
	if err != nil {
		panic("error when load config")
	}
	runtime.GOMAXPROCS(8)
	tcpServer(8889)
}

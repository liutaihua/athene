/*
author: liutaihua  defage@gmail.com
*/
package main

import (
	"bufio"
	"database/sql"
	"encoding/json"
	"github.com/liutaihua/athene/common"
	"io/ioutil"
	"net"
	"os"
	"log"
	"sort"
	//"runtime"
	"strconv"
	"strings"
	"os/signal"
	"syscall"
	"sync"
	"time"
	"errors"
)

func tcpServer(port int) {
	var addr = "0.0.0.0:" + strconv.Itoa(port)
	listener, err := net.Listen("tcp", addr)
	log.Println("start listen:", addr)
	if err != nil {
		log.Println("error listen: %s", err)
		os.Exit(1)
	}
	for {
		conn, err := listener.Accept()
		if err != nil {
			log.Println("error happend")
			continue
		}
		go handler(conn)
	}
}

func handler(conn net.Conn) {
	defer conn.Close()
	defer func() {
		if err := recover(); err != nil {
			log.Println(err)
		}
	}()
	reader := bufio.NewReader(conn)
	for {
		data, isPrefix, err := reader.ReadLine()
		if isPrefix || err != nil {
			log.Println("error conn.Read or isPrefix", err)
			return
		}
		msg := string(data)
		category_and_line := strings.SplitN(msg, " ", 2)
		if len(category_and_line) < 2 {
			continue
		}
		category := category_and_line[0]
		line := category_and_line[1]
		//log.Println(msg)

		if strings.Count(line, "profile=") > 0 || strings.Count(line, "fps:") > 0 || strings.Count(line, "[flash]") > 0 || strings.Count(line, "[equipment_destory]") > 0 {
			//log.Println("profile/save || msg/diagnostic  SKIP")
			continue
		}
		argsMap := common.StrToMap(line)
		userid := common.GetValMap(argsMap, "userid")
		int_userid, err := strconv.Atoi(userid)
		if int_userid == 0 || err != nil {
			log.Println("not found userid skip:", argsMap)
			continue
		}
		channel_id := strconv.Itoa((int_userid >> 16) >> 34)
		//db := platform_db_map[channel_id]
		db, err := getDB(channel_id)
		if err != nil {
			return
		}

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
			log.Println("not found corresponding db table")
		}
		//log.Println("done")
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
		log.Println("connect to mysql failed")
		panic(err)
	}
	db.SetMaxIdleConns(100)
	return db
}

func getDB(channelid string) (db *sql.DB, err error) {
	if channelid == "0" {
		return nil, errors.New("incorrect channelid")
	}
	if platform_db_map == nil {
		dbName, is_ok := cfg[channelid].(string)
		if !is_ok {
		        e := "nil platform_db_map found. not found from cfg by channelid:" + channelid
			panic(e)
		}
		db = GetDBConn(dbName)
		platform_db_map[channelid] = db
		return db, nil
	}
	db, is_ok := platform_db_map[channelid]
	if !is_ok {
		dbName, is_ok := cfg[channelid].(string)
		if !is_ok {
		        e := "not found from cfg by channelid: " + channelid
			panic(e)
		}
		db = GetDBConn(dbName)
		platform_db_map[channelid] = db
	}
	return db, nil
}

func loadConfig(is_first bool) {
	mu.Lock()
	defer mu.Unlock()
	var byt []byte;
	byt, err = ioutil.ReadFile("./config.json")
	if err != nil {
		log.Println("parse config", err)
		if is_first {
			os.Exit(1)
		}
	}
	err = json.Unmarshal(byt, &cfg)
	if err != nil {
		log.Println("error``````````", err)
		if is_first {
			os.Exit(1)
		}
	}

	var keys []int
	for k, _ := range cfg {
		intKey, _ := strconv.Atoi(k)
		keys = append(keys, intKey)
	}
	sort.Ints(keys)
	for _, k := range keys {
		log.Println("platformid:", k, "db name:", cfg[strconv.Itoa(k)])
	}
	log.Println("load config done.")
}

var platform_db_map = map[string]*sql.DB{}
var cfg map[string]interface{}
var mu = new(sync.RWMutex)

func main() {
	var err error
	loadConfig(true)
	if err != nil {
		panic("error when load config")
	}
	time.Sleep(time.Second*3)
	ch := make(chan os.Signal, 1)
	signal.Notify(ch, syscall.SIGUSR2)
	go func() {
		for {
			sg := <-ch
			loadConfig(false)
			log.Println("got signal:", sg)
			log.Println("reload config success")
		}
	}()
	//runtime.GOMAXPROCS(runtime.NumCPU())		// please use 'export GOMAXPROCS=4' instead this
	tcpServer(8888)
}

/*
author: liutaihua  defage@gmail.com
*/
//package main
package common

import (
    "fmt"
    "strings"
    "strconv"
    "database/sql"
    "encoding/json"
    _ "github.com/go-sql-driver/mysql"
    "github.com/likexian/simplejson"
)

var MySQLPool chan *sql.DB
var MAX_POOL_SIZE = 100
var MySQLDB *sql.DB
var err error

func GetDBConn() *sql.DB {
    user := "terminus"
    passwd := "daydayup"
    db := "athene"
    connArgs := user + ":" + passwd + "@/" + db + "?charset=utf8"

    MySQLDB, err = sql.Open("mysql", connArgs)
    MySQLDB.SetMaxIdleConns(100)
    err = MySQLDB.Ping()
    if err != nil {
        fmt.Println("connect to mysql failed")
	panic(err)
    }
    return MySQLDB
}

func GetMySQL() *sql.DB {
    if MySQLPool == nil {
        MySQLPool = make(chan *sql.DB, MAX_POOL_SIZE)
    }
    //host := ""
    //port := 3306
    user := "terminus"
    passwd := "daydayup"
    db := "athene"
    //connArgs := user + ":" + passwd + "@/" + db + "?charset=utf8"
    connArgs := user + ":" + passwd + "@unix(/tmp/mysql.sock)/" + db + "?charset=utf8"

    if len(MySQLPool) == 0 {
        go func() {
	    for i:=0;i<MAX_POOL_SIZE/2;i++ {
		mysql, err := sql.Open("mysql", connArgs)
		if err != nil{
		    panic(err)
		}
		pushToPool(mysql)
	    }
	}()
    }
    return <-MySQLPool
}

func pushToPool(conn *sql.DB) {
    if MySQLPool == nil {
        MySQLPool = make(chan *sql.DB, MAX_POOL_SIZE)
    }
    if len(MySQLPool) == MAX_POOL_SIZE {
        conn.Close()
        return
    }
    MySQLPool <- conn
}


//func InsertToMySQL(dbClient *sql.DB, tableName string, argsMap *simplejson.Json){
func InsertToMySQL(dbClient *sql.DB, tableName string, argsMap map[string]interface{}) {
    if dbClient == nil {
        return
    }
    var preSql string
    if IsStringInSlice(tableName, []string{"attr_log", "token_and_coupons_log"}) {
        preSql = "INSERT INTO " + tableName + " VALUES(?,?,?,?,?,?,?,?,?,?)"
    } else if tableName == "package" {
        preSql = "INSERT INTO " + tableName + " VALUES(?,?,?,?,?,?,?,?,?)"
    } else if tableName == "behavior_log" {
        preSql = "INSERT INTO " + tableName + " VALUES(?,?,?,?,?)"
    } else{
        fmt.Println("not table to insert")
        return
    }
    stmt, err := dbClient.Prepare(preSql)
    if err!=nil {
        fmt.Println(err.Error())
        return
    }
    defer stmt.Close();
    //result, err := stmt.Exec("1125899906973697", "gold", "2014-05-30 14:04:44", "5695", "1", "306", "dump_data", "992134", "1", "0")
    userid := GetValMap(argsMap, "userid")
    int_userid, err := strconv.Atoi(userid)
    if int_userid == 0 || err != nil {
        fmt.Println("fuckkkkkkk userid error", userid)
        fmt.Println("kkkkkkkkkkkkk ", argsMap)
	return
    }
    serverid := int_userid % 65536
    //fmt.Println("fffffffffffffffff, SERVERID-->", serverid)
    time := strings.Split(GetValMap(argsMap, "time"), ".")
    timestamp, time_tail := time[0], time[1]

    allow_list := []string {"go_to_boss", "jump_to_team_instance", "goto_challenge_instance", "go_to_battleland", "go_to_jjc", "go_to_singlejjc",
                "enhance", "combine", "mosaic", "generate_element", "update_miracle", "advance_update_miracle", "update_farm", "click", "pray",
                "harvest", "take_care","exchange", "jump_to_quest_location"}

    if IsStringInSlice(tableName, []string{"attr_log", "token_and_coupons_log"}) {
        attr := GetValMap(argsMap, "attr")
        old_data := GetValMap(argsMap, "old_data")
        delta_type := GetValMap(argsMap, "delta_type")
        delta_data := GetValMap(argsMap, "delta_data")
        source := GetValMap(argsMap, "source")
        balance_str := GetValMap(argsMap, "balance")
	var balance int
	if balance_str == "" || balance_str == "0" {
	    balance = 0
	} else {
	    balance = 1
	}
        stmt.Exec(userid, attr, timestamp, old_data, delta_type, delta_data, source, time_tail, serverid, balance)
    } else if tableName == "package" {
        itemtype := GetValMap(argsMap, "itemtype")
        count := GetValMap(argsMap, "count")
        consume_or_get_str := GetValMap(argsMap, "type")
        itemid := GetValMap(argsMap, "itemid")
        source := GetValMap(argsMap, "source")
        var consume_or_get int
        if consume_or_get_str == "get" {
            consume_or_get = 1
        } else {
            consume_or_get = 0
        }
        stmt.Exec(userid, timestamp, time_tail, itemtype, count, source, consume_or_get, itemid, serverid)
    } else if tableName == "behavior_log" {
        behavior := GetValMap(argsMap, "behavior")
        raw_action := GetValMap(argsMap, "uri")
        slice_action := strings.Split(raw_action, "/")
        action := slice_action[len(slice_action)-1]
	//fmt.Println("fffffffffff behavilog table", action)
        if IsStringInSlice(action, allow_list) {
	    //fmt.Println("fffffffffff behavilog", action)
	    //fmt.Println("fffffffffff behavilog", behavior)
            if behavior == "" {
                behavior = action
            }
        } else {
            return
        }
        stmt.Exec(userid, behavior, timestamp, time_tail, serverid)
    } else{
        fmt.Println("not table to insert")
        return
    }
}

func IsStringInSlice(a string, list []string) bool {
    for _, b := range list {
        if b == a {
            return true
        }
    }
    return false
}


func Subslice(s []string, f func(string) bool) []string {
    r := make([]string, 0)
    for _, v := range s {
        if f(v) {
            r = append(r, v)
        }
    }
    return r
}

func StrToJson(s string) *simplejson.Json {
    str_list := strings.Split(s, " ")
    sub_list := Subslice(str_list, func(v string) bool { return strings.ContainsAny(v, "=") })
    subStr := strings.Join(sub_list, "&&")

    //fmt.Println("wwwwwwwwwwwwwwww", subStr)
    subStr = strings.Replace(subStr, ":null", ":\"test\"", 100)
    subStr = strings.Replace(subStr, "=", "\":\"", 100)
    subStr = strings.Replace(subStr, "&&", "\",\"", 100)
    subStr = strings.Replace(subStr, "\"{", "{", 100)
    subStr = "{\"" + subStr + "\"}"
    subStr = strings.Replace(subStr, "}\"", "}", 100)
    //fmt.Println("aaaaaaaaaaaa", subStr)
    json, err := simplejson.Loads(subStr)
    if err != nil {
        fmt.Println("StrToJson ERROR:", err)
    }
    return json
    //fmt.Println(json)
    //fmt.Println(json.Get("userid").String())
}

func StrToMap(s string) map[string]interface{} {
    str_list := strings.Split(s, " ")
    sub_list := Subslice(str_list, func(v string) bool { return strings.ContainsAny(v, "=") })
    subStr := strings.Join(sub_list, "&&")

    //fmt.Println("wwwwwwwwwwwwwwww", subStr)
    subStr = strings.Replace(subStr, ":null", ":\"test\"", 100)
    subStr = strings.Replace(subStr, "=", "\":\"", 100)
    subStr = strings.Replace(subStr, "&&", "\",\"", 100)
    subStr = strings.Replace(subStr, "\"{", "{", 100)
    subStr = "{\"" + subStr + "\"}"
    subStr = strings.Replace(subStr, "}\"", "}", 100)
    byt := []byte(subStr)
    var dat map[string]interface{}
    if err:= json.Unmarshal(byt, &dat); err != nil{
        panic(err)
    }
    return dat
}

func GetValMap(m map[string]interface{}, key string) string {
    val, isOk := m[key].(string)
    if !isOk && key != `balance`{
        fmt.Println("not found key:", key)
    }
    return val
}

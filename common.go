//package main
package common

import (
    "fmt"
    "strings"
    "strconv"
    "database/sql"
    _ "github.com/go-sql-driver/mysql"
    "github.com/likexian/simplejson"
)

var MySQLPool chan *sql.DB
var MAX_POOL_SIZE = 100

func GetMySQL() *sql.DB {
    if MySQLPool == nil {
        MySQLPool = make(chan *sql.DB, MAX_POOL_SIZE)
    }
    //host := ""
    //port := 3306
    user := "terminus"
    passwd := "daydayup"
    db := "athene"
    connArgs := user + ":" + passwd + "@/" + db + "?charset=utf8"

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


func InsertToMySQL(dbClient *sql.DB, tableName string, argJson *simplejson.Json){
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
    userid := GetStrFromJson(argJson, "userid")
    int_userid, err := strconv.Atoi(userid)
    if int_userid == 0 || err != nil {
        fmt.Println("fuckkkkkkk userid error", userid)
        fmt.Println("kkkkkkkkkkkkk ", argJson)
	return
    }
    serverid := int_userid % 65536
    fmt.Println("fffffffffffffffff, SERVERID-->", serverid)
    timestamp := GetStrFromJson(argJson, "timestamp")
    time_tail := GetStrFromJson(argJson, "time_tail")
    allow_list := []string {"go_to_boss", "jump_to_team_instance", "goto_challenge_instance", "go_to_battleland", "go_to_jjc", "go_to_singlejjc",
                "enhance", "combine", "mosaic", "generate_element", "update_miracle", "advance_update_miracle", "update_farm", "click", "pray",
                "harvest", "take_care","exchange", "jump_to_quest_location"}

    if IsStringInSlice(tableName, []string{"attr_log", "token_and_coupons_log"}) {
        attr := GetStrFromJson(argJson, "attr")
        old_data := GetStrFromJson(argJson, "old_data")
        delta_type := GetStrFromJson(argJson, "delta_type")
        delta_data := GetStrFromJson(argJson, "delta_data")
        source := GetStrFromJson(argJson, "source")
        balance_str := GetStrFromJson(argJson, "balance")
	var balance int
	if balance_str == "" || balance_str == "0" {
	    balance = 0
	} else {
	    balance = 1
	}
        _, err = stmt.Exec(userid, attr, timestamp, old_data, delta_type, delta_data, source, time_tail, serverid, balance)
    } else if tableName == "package" {
        itemtype := GetStrFromJson(argJson, "itemtype")
        count := GetStrFromJson(argJson, "count")
        consume_or_get_str := GetStrFromJson(argJson, "type")
        itemid := GetStrFromJson(argJson, "itemid")
        source := GetStrFromJson(argJson, "source")
        var consume_or_get int
        if consume_or_get_str == "get" {
            consume_or_get = 1
        } else {
            consume_or_get = 0
        }
        _, err = stmt.Exec(userid, timestamp, time_tail, itemtype, count, source, consume_or_get, itemid, serverid)
    } else if tableName == "behavior_log" {
        behavior := GetStrFromJson(argJson, "behavior")
        raw_action := GetStrFromJson(argJson, "uri")
        slice_action := strings.Split(raw_action, "/")
        action := slice_action[len(slice_action)-1]
	//fmt.Println("fffffffffff behavilog table", action)
        if IsStringInSlice(action, allow_list) {
	    fmt.Println("fffffffffff behavilog", action)
	    fmt.Println("fffffffffff behavilog", behavior)
            if behavior == "" {
                behavior = action
            }
        } else {
            return
        }
        _, err = stmt.Exec(userid, behavior, timestamp, time_tail, serverid)
    } else{
        fmt.Println("not table to insert")
        return
    }


    if err != nil {
        fmt.Println(err)
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
    subS := strings.Join(sub_list, "&&")

    //fmt.Println("wwwwwwwwwwwwwwww", subS)
    subS = strings.Replace(subS, ":null", ":\"test\"", 100)
    subS = strings.Replace(subS, "=", "\":\"", 100)
    subS = strings.Replace(subS, "&&", "\",\"", 100)
    subS = strings.Replace(subS, "\"{", "{", 100)
    subS = "{\"" + subS + "\"}"
    subS = strings.Replace(subS, "}\"", "}", 100)
    //fmt.Println("aaaaaaaaaaaa", subS)
    json, err := simplejson.Loads(subS)
    if err != nil {
        fmt.Println("StrToJson ERROR:", err)
    }
    return json
    //fmt.Println(json)
    //fmt.Println(json.Get("userid").String())
}

func GetStrFromJson(json *simplejson.Json, key string) string {
    //fmt.Print("get string from json:", key, "\n")
    if key == "time_tail" {
        res, _ := json.Get("time").String()
	return strings.Split(res, ".")[1]
    } else if key == "timestamp" {
        res, _ := json.Get("time").String()
        return strings.Split(res, ".")[0]
    } else {
        res, err := json.Get(key).String()
	if err != nil {
	    fmt.Println("no such key", key)
	}
	return res
    }
}

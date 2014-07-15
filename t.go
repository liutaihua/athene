package main

import (
	"encoding/json"
	"reflect"
	"fmt"
)

type OriginJSON struct {
	Eight string `json:"8"`
	Nine  string `json:"9"`
}

func GetValMap(m map[string]interface{}, key string) interface{} {
    val, isOk := m[key].(string)
    if !isOk {
        fmt.Println("not found key:", key)
    }
    return val
}

func main() {
	var x OriginJSON
	json.Unmarshal([]byte(`{"8" : "abc", "9" : "cba", "s": "222", "b": "fff"}`), &x)
	fmt.Println(x)
	byt := []byte(`{"s": "b", "sha": "gua"}`)
	var dat map[string]interface{}
	json.Unmarshal(byt, &dat)

	val := GetValMap(dat, "s")
	fmt.Println("222222222222", val, reflect.TypeOf(val))
}

package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"
	"strings"
)

func main() {
	addr := ":8080"
	http.HandleFunc("/", root)
	err := http.ListenAndServe(addr, nil)
	if err != nil {
		log.Fatal(err)
	}
}

func root(w http.ResponseWriter, r *http.Request) {
	var inpStr string
	for _, segment := range strings.Split(r.RequestURI, "/") {
		inpStr = segment
	}
	inp, err := strconv.ParseInt(inpStr, 10, 64)
	if err != nil {
		log.Printf("Error parsing path param '%s' as int", inpStr)
		w.Write([]byte("0"))
		return
	}

	var result int64
	if inp == 0 {
		result = httpGetInt("http://base-factorial.apps.internal:8080/")
	} else {
		result = inp * httpGetInt(fmt.Sprintf("http://factorial.apps.internal:8080/%d", inp-1))
	}
	w.Write([]byte(fmt.Sprintf("%d", result)))
}

func httpGetInt(url string) int64 {
	resp, err := http.Get(url)
	if err != nil {
		log.Printf("Error getting '%s'", url)
		return 0
	}
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Printf("Error reading response body for url '%s'", url)
		return 0
	}
	bodyStr := string(body)
	bodyInt, err := strconv.ParseInt(strings.Trim(bodyStr, "\r\n 	"), 10, 64)
	if err != nil {
		log.Printf("Error parsing response body ('%s') for url '%s' as int", bodyStr, url)
		return 0
	}
	return bodyInt
}

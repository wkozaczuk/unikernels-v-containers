package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"math"
	"net/http"
	"os"
	"strconv"
	"time"
)

//call with go run Tester.go http://methoduri arraysize iterations
func main() {
	fmt.Println("Starting tester")
	argsWithoutProg := os.Args[1:]

	testUrl := argsWithoutProg[0]
	testSize, _ := strconv.Atoi(argsWithoutProg[1])
	iterations, _ := strconv.Atoi(argsWithoutProg[2])

	numbers := make([]int, testSize)
	for i := 0; i < testSize; i++ {
		numbers[i] = testSize - i
	}

	jsonValue, _ := json.Marshal(numbers)

	//fmt.Printf("Testdata %s\n", jsonValue)

	totalTime := int64(0)
	sqrtTimes := int64(0)
	for iter := 0; iter < iterations; iter++ {
		start := time.Now()
		_, err := http.Post(testUrl, "application/json", bytes.NewBuffer(jsonValue))
		elapsed := time.Since(start)

		ms := int64(elapsed / time.Millisecond)
		fmt.Printf("%d\n", int64(elapsed/time.Millisecond))

		//statistics
		totalTime += ms
		sqrtTimes += ms * ms

		if err != nil {
			fmt.Printf("The HTTP request failed with error %s\n", err)
		} else {
			//data, _ := ioutil.ReadAll(response.Body)
			//fmt.Println(string(data))
		}
	}

	avg := totalTime / int64(iterations)
	variance := (sqrtTimes / int64(iterations)) - (avg * avg)
	fmt.Printf("Avg ms: %d stdev ms: %f\n", avg, math.Sqrt(float64(variance)))
	fmt.Println("Stopping tester")
}

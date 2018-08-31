package main

import (
	"encoding/json"
	"net/http"
)

func PostBubbleSort(w http.ResponseWriter, r *http.Request) {
	decoder := json.NewDecoder(r.Body)
	var numbers []int
	if err := decoder.Decode(&numbers); err != nil {
		panic(err)
	}

	output := BubbleSort(numbers)
	if err := json.NewEncoder(w).Encode(output); err != nil {
		panic(err)
	}
}

func BubbleSort(numbers []int) []int {
	n := len(numbers)

	for i := 0; i < n-1; i++ {
		for j := 0; j < n-i-1; j++ {
			if numbers[j] > numbers[j+1] {
				numbers[j], numbers[j+1] = numbers[j+1], numbers[j]
			}
		}
	}
	return numbers
}

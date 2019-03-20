package main

import (
    "encoding/json"
    "fmt"
    "net/http"
    "strconv"

    "github.com/gorilla/mux"
)

func InitTodos() []Todo {
    return []Todo {
        Todo { Name: "Write presentation" },
        Todo { Name: "Host meetup" },
	Todo { Name: "Run tests" },
	Todo { Name: "Stand in traffic" },
	Todo { Name: "Learn Go" },
    }
}

func Index(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintln(w, "Welcome!")
}

func TodoIndex(w http.ResponseWriter, r *http.Request) {
    todos := InitTodos()

    if err := json.NewEncoder(w).Encode(todos); err != nil {
        panic(err)
    }
}

func TodoById(w http.ResponseWriter, r *http.Request) {
    todos := InitTodos()

    vars := mux.Vars(r)
    todoId, _ := strconv.Atoi(vars["todoId"])

    if todoId < len(todos) {
   	todoObj := todos[todoId]

	if err := json.NewEncoder(w).Encode(todoObj); err != nil {
            panic(err)
        }
    } else {
	fmt.Fprintln(w, "Todo not found:", todoId)
    }
}

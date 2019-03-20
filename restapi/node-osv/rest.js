let os = require('os');
let express = require('express');
let app = express();

let todos = [
  {name:'Write presentation'},
  {name:'Host meetup'},
  {name:'Run tests'},
  {name: 'Stand in traffic'},
  {name: 'Learn Rust'}
];

app.get('/', function (req, res) {
  res.send('Welcome from Node and Express on OSv')
});

app.get('/todos', function (req, res) {
  res.send(todos);
});

app.get('/todos/:todoId', function (req, res) {
  let id = parseInt(req.params.todoId);
  if (id !== NaN && (id >= 0 && id < todos.length))
    res.send(todos[id]);
  else
    res.sendStatus(404);
});

console.log("Detected " + os.cpus().length + " CPUs");
console.log("Listening on port 8080 ...");
app.listen(8080);

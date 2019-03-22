let os = require('os');
let express = require('express');
let app = express();

let todos = [
  {name:'Write presentation', completed:false, due: new Date()},
  {name:'Host meetup', completed:false, due: new Date()},
  {name:'Run tests', completed:false, due: new Date()},
  {name: 'Stand in traffic', completed:false, due: new Date()},
  {name: 'Learn Rust', completed:false, due: new Date()}
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

if (os.cpus())
  console.log("Detected " + os.cpus().length + " CPUs");
else
  console.log("Could not detect number of CPUs!");

console.log("Node.js listening on port 8080 ...");
app.listen(8080);

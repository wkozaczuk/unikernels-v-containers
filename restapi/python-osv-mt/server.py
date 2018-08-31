import sys

print '\n'.join(sys.path)

from flask import Flask, request
from flask_restful import Resource, Api
from json import dumps
from flask import jsonify
from datetime import datetime
import logging


app = Flask(__name__)
api = Api(app)

log = logging.getLogger('werkzeug')
log.setLevel(logging.ERROR)

class Todo:
    def __init__(self, pname, pcompleted, pdue):
        self.name = pname
        self.completed = pcompleted
        self.due = pdue

class Index(Resource):
    def get(self):
        return 'Welcome'

class TodoIndex(Resource):
    def get(self):
        todos = []
        todos.append(Todo("Write presentation", False, datetime.now()))
        todos.append(Todo("Host meetup", False, datetime.now()))
        todos.append(Todo("Run tests", False, datetime.now()))
        todos.append(Todo("Stand in traffic", False, datetime.now()))
        todos.append(Todo("Learn Python", False, datetime.now()))
        return jsonify([todo.__dict__ for todo in todos])

class TodoById(Resource):
    def get(self, todo_id):
        todos = []
        todos.append(Todo("Write presentation", False, datetime.now()))
        todos.append(Todo("Host meetup", False, datetime.now()))
        todos.append(Todo("Run tests", False, datetime.now()))
        todos.append(Todo("Stand in traffic", False, datetime.now()))
        todos.append(Todo("Learn Python", False, datetime.now()))
        return jsonify(todos[int(todo_id)].__dict__)
        

api.add_resource(Index, '/') # Route_1
api.add_resource(TodoIndex, '/todos') # Route_2
api.add_resource(TodoById, '/todos/<todo_id>') # Route_3

app.run(host='0.0.0.0', port='8080', threaded=True)

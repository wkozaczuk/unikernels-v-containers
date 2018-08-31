import sys

print '\n'.join(sys.path)

from flask import Flask, request
from flask_restful import Resource, Api
from json import dumps
from flask import jsonify
from datetime import datetime
import logging, json


app = Flask(__name__)
api = Api(app)

log = logging.getLogger('werkzeug')
log.setLevel(logging.ERROR)

class PostSort(Resource):
    def post(self):
        numbers = request.json
        #numbers = json.loads(jsonNumbers)
        self.bubbleSort(numbers)
        return jsonify(numbers)
    def bubbleSort(self, alist):
        for passnum in range(len(alist)-1,0,-1):
            for i in range(passnum):
                if alist[i]>alist[i+1]:
                    temp = alist[i]
                    alist[i] = alist[i+1]
                    alist[i+1] = temp
        
        
api.add_resource(PostSort, '/sort') # Route_3

app.run(host='0.0.0.0', port='8080')

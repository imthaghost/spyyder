"""Authentication route"""

from zeus_api.models.user import User
from flask_restful import Resource
from random import randint
from flask import jsonify
import zeus_api
import json
from bson import json_util


class tokenAuth(Resource):
    def get(self):
        user = User(email=randint(0, 300))
        data = user.serialize()
        print(data)
        zeus_api.user.insert_one(json.loads(json_util.dumps(data)))
        return jsonify(data)

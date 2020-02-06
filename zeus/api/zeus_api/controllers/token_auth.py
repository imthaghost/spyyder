"""Authentication route"""

from zeus_api.models.user import User
from zeus_api.controllers.auth import token_required
from zeus_api.models.company import Company
from flask_restful import Resource
from random import randint
from flask import jsonify
import zeus_api
import json
from bson import json_util
from flask import request
import os


class tokenAuth(Resource):
    def post(self):
        r = request.get_json().get('email')
        user = User(email=r)
        user_data = user.serialize()
        return jsonify(user_data)


class grabber(Resource):
    @token_required
    def get(self):
        return 'Yup'


class up(Resource):
    def get(self):
        key = os.getenv('secret_key')
        return key

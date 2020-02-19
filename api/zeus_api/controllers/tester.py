"""Authentication route"""

from zeus_api.models.user import User
from zeus_api.utils.auth import token_required
from zeus_api.models.company import Company
from flask_restful import Resource
from random import randint
from flask import jsonify
import zeus_api
import json
from bson import json_util
from flask import request
import os


class grabber(Resource):
    @token_required
    def get(self):
        return 'Yup'


class up(Resource):
    def get(self):
        key = os.getenv('secret_key')
        return key


class wipe(Resource):
    def get(self):
        zeus_api.user.delete_many({})
        return jsonify({'message': 'fresh start :) '})

"""Company Details Endpoint"""
from flask import request
from flask_restful import Resource, abort
from bson.objectid import ObjectId
from zeus_api.controllers.auth import token_required
from bson import json_util
from flask import jsonify
import zeus_api
import json


class companyDetails(Resource):
    def get(self):

        return jsonify({'company': 'some name goes here'})

    def post(self):
        # todo later
        return jsonify({'message': 'hi'})

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
    @token_required
    def get(self, data, token):
        if data is None or token is None:
            return jsonify({'message' 'empty data or token variable'})

        company = zeus_api.company.find_one(
            {'_id': ObjectId(data.get('uuid'))})
        print(data)
        print(token)
        print(company)
        return jsonify({'success': 'returned company'})

    def post(self):
        pass

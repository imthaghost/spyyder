"""Company Details Endpoint"""
from flask_restful import Resource, abort
from bson.objectid import ObjectId
from zeus_api.controllers.auth import token_required
from bson import json_util
from flask import jsonify
import zeus_api
import json


class companyDetails(Resource):
    @token_required
    def get(self, companyid):
        company = zeus_api.company.find_one({'_id': ObjectId(companyid)})
        print(type(company))
        return company.get('ticker')

    def post(self):
        pass

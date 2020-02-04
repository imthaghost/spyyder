"""User details"""
from flask_restful import Resource, abort
from flask import jsonify
import zeus_api
import json
from bson import json_util
from bson.objectid import ObjectId


# def missing_user_id(id):
#     if id not in zeus_api.user.find_one({"_id": id}):
#         abort(404, message="User {} doesn't exist".format(id))


class JSONEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, ObjectId):
            return str(o)
        return json.JSONEncoder.default(self, o)


class User_details(Resource):
    def get(self, userid):
        # identifier = JSONEncoder(userid)
        user_data = zeus_api.user.find_one({'_id': ObjectId(userid)})
        email = user_data['email']
        return jsonify(email)

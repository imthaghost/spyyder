"""User details"""
from flask_restful import Resource, abort
from bson.objectid import ObjectId
from bson import json_util
from flask import jsonify
import zeus_api
import json

# local python modules
from zeus_api.controllers.auth import access_token_required, token_required

# def missing_user_id(id):
#     if id not in zeus_api.user.find_one({"_id": id}):
#         abort(404, message="User {} doesn't exist".format(id))


class User_details(Resource):
    @token_required
    def get(self, data, token):
        uuid = data.get('uuid')
        current_user = zeus_api.user.find_one({'uuid': uuid})
        if current_user is not None:
            print(current_user)
            return jsonify({'success': current_user.get('fullname')})
        else:
            return jsonify({'error': 'server error'})

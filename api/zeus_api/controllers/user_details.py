"""User details"""
from flask_restful import Resource
from flask import jsonify
import zeus_api
import json

# local python modules
from zeus_api.utils.auth import token_required


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

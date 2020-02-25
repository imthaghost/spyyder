"""User details"""
# external python modules
from flask_restful import Resource
from bson import json_util
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
        print(current_user)
        if current_user is not None:
            print(current_user)
            user_data = json.loads(json_util.dumps(current_user))
            return jsonify({'success': user_data})
        else:
            return jsonify({'error': 'server error'})

# built in python modules
from functools import wraps
import os
# external python modules
from flask import jsonify, request
import jwt

# local python modules
import zeus_api


def token_required(f):
    @wraps(f)
    def wrapper(*args, **kwargs):
        # {'token' : hfwe86732tv2hjr4h827ybuf}
        token = request.get_json().get('token')
        if not token:
            return jsonify({'message': 'token is missing'})
        try:
            data = jwt.decode(token, os.getenv('secret_key'))
            current_user = zeus_api.user.find_one({'uuid': data.get('uuid')})
            if current_user:
                kwargs['data'] = data
                kwargs['token'] = token
            else:
                return jsonify({'Message: ': 'invalid token'})
        except:
            return jsonify({'Message': 'server error'})

        return f(*args, **kwargs)

    return wrapper

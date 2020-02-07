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
        try:
            token = request.get_json().get('token')
        except Exception as e:
            print(e)
            token = None
        finally:
            if not token:
                return jsonify({'message': 'token is missing'})
        try:
            data = jwt.decode(token, os.getenv('secret_key'))
        except:
            return jsonify({'Error: ': 'server error'})
        return f(*args, **kwargs)
    return wrapper


def access_token_required(f):
    @wraps(f)
    def wrapper(*args, **kwargs):
        if 'token' in request.get_json():
            print(request.get_json())
            print(request.headers)
            token = request.get_json().get('token')
        if not token:
            return jsonify({'message': 'Missing token'})
        try:
            data = jwt.decode(token, os.getenv('secret_key'))
            current_user = zeus_api.user.find_one({'uuid': data.get('uuid')})
            son = {current_user}
        except:
            return jsonify({'message': 'Token is invalid'})

        return f(son, *args, **kwargs)

    return access_token_required

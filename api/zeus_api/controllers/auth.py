# built in modules
from functools import wraps
# external modules
from flask import jsonify, request
import jwt


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
            data = jwt.decode(token, 'key')
        except:
            return jsonify({'Error: ': 'server error'})
        return f(*args, **kwargs)
    return wrapper

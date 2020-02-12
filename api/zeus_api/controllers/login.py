# built in modules
import datetime
import os
# external modules
from flask import jsonify, make_response, request
from flask_restful import Resource
import bcrypt
import jwt
# local modules
import zeus_api


class authenticate(Resource):
    def post(self):
        # store the sent over json from client
        credentials = request.get_json()
        if credentials is None:
            return jsonify({'message': 'no data was sent'})

        print(credentials)
        email = credentials.get('email')
        password = credentials.get('password')
        # todo: make sure to sanitize unless you want SQL Injection :)
        verify_user = zeus_api.user.find_one({'email': email})
        # if the users email is foudd in the database and check to see if the password credential matches the encrypted field in the database
        if verify_user is not None:
            # and bcrypt.hashpw(password.encode('utf-8'), verify_user['password']) == password
            # create unique token when user is verified
            # todo make expiration time reasonable
            token = jwt.encode({'uuid': verify_user.get('uuid'), 'exp': datetime.datetime.utcnow(
            ) + datetime.timedelta(minutes=4)}, os.getenv('secret_key'))
            # send the token back
            return jsonify({'token': token.decode('UTF-8')})
        else:
            return make_response('Cannot verify', 401, {'Authencation': 'Basic realm="Login Reqiured"'})

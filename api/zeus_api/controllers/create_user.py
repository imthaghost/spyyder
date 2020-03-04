# built in modules
import datetime
# external modules
from flask import jsonify, make_response, request
from flask_restful import Resource
import bcrypt
import jwt
# local modules
import zeus_api


class create(Resource):
    def post(self):
        # store the sent over json from client
        data = request.get_json()
        fullname = data.get('fullname')
        email = data.get('email')
        password = data.get('password')
        # todo: make sure to sanitize unless you want SQL Injection :)
        verify_email = zeus_api.user.find_one({'email': email})
        # if the users email is found in the database and check to see if the password credential matches the encrypted field in the database
        if verify_email is None:
            current_user = zeus_api.models.user.User(
                fullname, email=email, password=password)
            # generate UUID
            current_user.set_uuid()
            # save user to proper collection in database
            current_user.save_new()
            # todo generate a unique token with using the UUID have user click a link to verify
            # return json success message for now
            return jsonify({'success': 'user has been created'})
        else:
            error_message = 'account already exists with ' + str(email)
            return jsonify({'message': error_message})

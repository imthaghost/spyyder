from flask import request, jsonify
from flask_restful import Resource
import zeus_api


class Vistitor(Resource):
    # HTTP post request
    def post(self):
        data = request.get_json()
        # check if the JSON body is empty
        if not data:
            # custom message
            return jsonify({"message": "empty request"})
        # assign client ip address
        client_ip = data.get('client_ip')
        # check to see if the visitor ip address is in database
        found = zeus_api.visitor.find_one({'ip': client_ip})
        # if found return true else save ip and return false
        if found:
            return jsonify({'existance': True})
        else:

            return jsonify({'existance': False})

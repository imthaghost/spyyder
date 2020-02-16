# external modules
from flask import jsonify, make_response, request
from flask_restful import Resource
# local modules
import zeus_api


class Subscribe(Resource):
    def get(self):
        return jsonify({'message': 'method not allowed'})

    def post(self):
        data = request.get_json()
        print('Data: ', data)
        if data:
            email = data.get('email')
            first_name = data.get('firstname')
            # serialized data
            subscribers = {
                'email': email,
                'firstname': first_name
            }
            print(subscribers)
            print(data)
            # update database
            zeus_api.user.insert_one(subscribers)
        return jsonify({'message': 'Thanks for subscribing'})
    

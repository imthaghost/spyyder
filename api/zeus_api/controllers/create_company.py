# built in modules
import datetime
# external modules
from flask import jsonify, make_response, request
from flask_restful import Resource
# local modules
import zeus_api


class create_company(Resource):
    def post(self):
        # store the sent over json from client
        data = request.get_json()
        name = data.get('name')
        logo = data.get('logo')
        price = data.get('price')
        description = data.get('description')
        volume = data.get('volume')
        ticker = data.get('ticker')
        news = data.get('news')
        totalshare = data.get('totalshares')

        # todo: make sure to sanitize unless you want SQL Injection :)
        verify_company = zeus_api.company.find_one({'ticker': ticker})
        # if the users email is found in the database and check to see if the password credential matches the encrypted field in the database
        if verify_company is None:
            current_company = zeus_api.models.company.Company()
            current_company.logo = logo
            current_company.name = name
            current_company.ticker = ticker
            current_company.stockprice = price
            current_company.volume = volume
            current_company.total_shares = totalshare
            current_company.description = description
            # generate UUID
            current_company.set_uuid()
            # save user to proper collection in database
            current_user.save_new()
            # todo generate a unique token with using the UUID have user click a link to verify
            # return json success message for now
            return jsonify({'success': 'company has been created'})
        else:
            error_message = 'company already exists'
            return jsonify({'message': error_message})

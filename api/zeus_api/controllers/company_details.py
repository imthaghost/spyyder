"""Company Details Endpoint"""
from flask import request
from flask_restful import Resource, abort
from bson.objectid import ObjectId
from zeus_api.controllers.auth import token_required
from bson import json_util
from flask import jsonify
import zeus_api
import json
import alpha_vantage


class companyDetails(Resource):
    @token_required
    def get(self, data, token):
        data = str(data) 
        data = data.lower()
        companies = { 'microsoft': 'MSFT', 'apple': 'AAPL', 'amazon':'AMZN', 'facebook':'FB', 'bank of america': 'BAC', 'boeing':'BA', 'intel','INTC', 'johnson&johnson': 'JNJ'}

        for item in companies:
            if data in companies:
                new_data = companies.get(item)
                return new_data
            else:
                return None

        api_key = 'IOLIXAXKGPI3A4QM'

        ts = TimeSeries(key=api_key, output_format='pandas') # turns data into a pandas dataframe
        data_ts, meta_data_ts = ts.get_intraday(symbol=new_data, interval='1min', outputsize='full') # all data, every minute, from MSFT
        df2 = data_ts['4. close'].iloc[period-1::] # we only want the closing column
        print('this is data: ' + str(df2)) # prints last closing price of chosen company


            if data is None or token is None:
                return jsonify({'message' 'empty data or token variable'})

            company = zeus_api.company.find_one(
                {'_id': ObjectId(data.get('uuid'))})
            print(data)
            print(token)
            print(company)
            return jsonify({'success': 'returned company'})

    def get(self):

        return jsonify({'company': 'some name goes here'})

    def post(self):
        # todo later
        return jsonify({'message': 'hi'})

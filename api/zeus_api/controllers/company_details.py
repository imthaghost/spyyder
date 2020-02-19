"""Company Details Endpoint"""
from flask import request
from flask_restful import Resource, abort
from bson.objectid import ObjectId
from zeus_api.utils.auth import token_required
from bson import json_util
from flask import jsonify
import zeus_api
import json
import alpha_vantage
import pandas as pd
from alpha_vantage.timeseries import TimeSeries
from alpha_vantage.techindicators import TechIndicators  # calculate sma for us


class companyDetails(Resource):
    @token_required
    def get(self, data, token):
        data = str(data)
        data = data.lower()
        # companies = { 'microsoft': 'MSFT', 'apple': 'AAPL', 'amazon':'AMZN', 'facebook':'FB', 'bank of america': 'BAC', 'boeing':'BA', 'intel','INTC', 'johnson&johnson': 'JNJ'}
        companies = {}
        for item in companies:
            if data in companies:
                new_data = companies.get(item)
                return new_data
            else:
                return None

        api_key = 'IOLIXAXKGPI3A4QM'

        # turns data into a pandas dataframe
        ts = TimeSeries(key=api_key, output_format='pandas')
        data_ts, meta_data_ts = ts.get_intraday(
            symbol=new_data, interval='1min', outputsize='full')  # all data, every minute, from MSFT
        # we only want the closing column
        df2 = data_ts['4. close'].iloc[period-1::]
        # prints last closing price of chosen company
        print('this is data: ' + str(df2))

        # if data is None or token is None:
        #     return jsonify({'message' 'empty data or token variable'})

        # company = zeus_api.company.find_one(
        #     {'_id': ObjectId(data.get('uuid'))})
        # print(data)
        # print(token)
        # print(company)

        return jsonify({'success': 'returned company'})

    def post(self):
        # todo later
        return jsonify({'message': 'hi'})

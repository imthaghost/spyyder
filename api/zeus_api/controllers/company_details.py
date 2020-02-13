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
        api_key = 'IOLIXAXKGPI3A4QM'

        ts = TimeSeries(key=api_key, output_format='pandas')
        data, meta_data = ts.get_intraday(symbol='MSFT', interval = '1min', outputsize = 'full')
        print(data)


        # infinite while loop that copies data stored into an excel sheet every minute
        # i = 1
        # while i == 1:
        #     data, meta_data = ts.get_intraday(symbol='MSFT', interval = '1min', outputsize = 'full')
        #     data.to_excel("output.xlsx")
        #     time.sleep(60)
        print('this is data: ' + str(data))
        close_data = data['4. close']
        print("Closing data: " + str(close_data))
        percentage_change = close_data.pct_change()

        print(percentage_change)

        last_change = percentage_change[-1] #pulls out last value in the closing series 

        if abs(last_change) > 0.0004: # if the absolute value is above .4 of a percent then make an alert 
            print('MSFT Alert: ' + str(last_change))

                if data is None or token is None:
                    return jsonify({'message' 'empty data or token variable'})

                company = zeus_api.company.find_one(
                    {'_id': ObjectId(data.get('uuid'))})
                print(data)
                print(token)
                print(company)
            return jsonify({'success': 'returned company'})

    def post(self):
        pass

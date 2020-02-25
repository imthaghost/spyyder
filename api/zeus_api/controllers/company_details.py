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
from alpha_vantage.timeseries import TimeSeries #api for realtime stock data
from alpha_vantage.techindicators import TechIndicators  # calculate sma for us


api_key = 'IOLIXAXKGPI3A4QM'
# turns data into a pandas dataframe
ts = TimeSeries(key=api_key, output_format='pandas')
# all data, every minute, from MSFT
data_ts, meta_data_ts = ts.get_intraday(symbol=new_data, interval='1min', outputsize='full')  
# we only want the closing column
df2 = data_ts['4. close'].iloc[-1]
# prints last closing price of chosen company
#print('this is data: ' + str(df2))


# helper function
def api(self, new_data, token):
    api_key = 'IOLIXAXKGPI3A4QM'
    ts = TimeSeries(key=api_key, output_format='pandas') # turns data into a pandas dataframe
    data_ts, meta_data_ts = ts.get_intraday(symbol=new_data, interval='1min', outputsize='full') # all data, every minute, from MSFT
    period = 60
    ti = TechIndicators(key=api_key, output_format='pandas')
    data_ti, meta_data_ti = ti.get_sma(symbol='MSFT', interval='1min', time_period=period, series_type='close')
    df2 = data_ts['4. close'].iloc[-1] # we only want the closing column
    return df2
# Company and Recent Price
class companyDetails(Resource):
    @token_required
    def get(self):
        data = request.get_json()
        company = str(data.get('companyname')).lower()
        companies = { 'microsoft': 'MSFT', 'apple': 'AAPL', 'amazon':'AMZN', 'facebook':'FB', 'bank of america': 'BAC', 'boeing':'BA', 'intel':'INTC', 'johnson&johnson': 'JNJ'}
        for item in companies:
            if company in companies:
                ticker = companies.get(item)
                closing_price = api(ticker)
            else:
                return None
        return jsonify({'company': ticker,'price': closing_price})

   



    #return ('this is data: ' +  str(new_data) + str( df2)) # prints last closing price of chosen company

        # if data is None or token is None:
        #     return jsonify({'message' 'empty data or token variable'})

        # company = zeus_api.company.find_one(
        #     {'_id': ObjectId(data.get('uuid'))})


# Example 
# company = companyDetails()
# company.get(microsoft)

       
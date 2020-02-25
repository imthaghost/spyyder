# simple moving average = p1 + p2 + p3 / n 
# this helps us identify trends in the stock price
# if the closing price differs from the sma then it may be time to buy or sell the stock 

import pandas as pd 
from alpha_vantage.timeseries import TimeSeries
from alpha_vantage.techindicators import TechIndicators # calculate sma for us

import matplotlib.pyplot as plt 


# api_key = 'IOLIXAXKGPI3A4QM'

# ts = TimeSeries(key=api_key, output_format='pandas')

# data_ts, meta_data_ts = ts.get_intraday(symbol='MSFT', interval='1min', outputsize='full') # all data, every minute, from MSFT

# period = 60 # 1 hour for sma

# ti = TechIndicators(key=api_key, output_format='pandas')
# data_ti, meta_data_ti = ti.get_sma(symbol='MSFT', interval='1min', time_period=period, series_type='close')

def get(data):
    data = str(data) 
    data = data.lower()
    companies = { 'microsoft': 'MSFT', 'apple': 'AAPL', 'amazon':'AMZN', 'facebook':'FB', 'bank of america': 'BAC', 'boeing':'BA', 'intel':'INTC', 'johnson&johnson': 'JNJ'}
    for item in companies:
        if data in companies:
            new_data = companies.get(item)
            return api(new_data)
        else:
            return None

def api(new_data):
    api_key = 'IOLIXAXKGPI3A4QM'
    ts = TimeSeries(key=api_key, output_format='pandas') # turns data into a pandas dataframe
    data_ts, meta_data_ts = ts.get_intraday(symbol=new_data, interval='1min', outputsize='full') # all data, every minute, from MSFT
    period = 60
    ti = TechIndicators(key=api_key, output_format='pandas')
    data_ti, meta_data_ti = ti.get_sma(symbol='MSFT', interval='1min', time_period=period, series_type='close')
    df2 = data_ts['4. close'].iloc[-1] # we only want the closing column
    return {'company': new_data,'price': df2}
   # return ('this is data: ' +  str(new_data) + str( df2)) # prints last closing price of chosen company

print(get('microsoft'))

# df1 = data_ti # the calculation of the 60 
# df2 = data_ts['4. close'].iloc[-1] # we only want the last item in the closing column
# print(df2)
#df2.index = df1.index

# total_df = pd.concat([df1, df2], axis=1)
# print(total_df)

# total_df.plot()
# plt.show()
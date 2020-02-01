# simple moving average = p1 + p2 + p3 / n 
# this helps us identify trends in the stock price
# if the closing price differs from the sma then it may be time to buy or sell the stock 

import pandas as pd 
from alpha_vantage.timeseries import TimeSeries
from alpha_vantage.techindicators import TechIndicators # calculate sma for us
import matplotlib.pyplot as plt 


api_key = 'IOLIXAXKGPI3A4QM'

ts = TimeSeries(key=api_key, output_format='pandas')

data_ts, meta_data_ts = ts.get_intraday(symbol='MSFT', interval='1min', outputsize='full') # all data, every minute, from MSFT

period = 60 # 1 hour for sma

ti = TechIndicators(key=api_key, output_format='pandas')
data_ti, meta_data_ti = ti.get_sma(symbol='MSFT', interval='1min', time_period=period, series_type='close')

  
df1 = data_ti # the calculation of the 60 
df2 = data_ts['4. close'].iloc[period-1::] # we only want the closing column

df2.index = df1.index

total_df = pd.concat([df1, df2], axis=1)
print(total_df)

total_df.plot()
plt.show()
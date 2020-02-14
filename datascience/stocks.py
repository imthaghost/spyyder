import pandas as pd
from alpha_vantage.timeseries import TimeSeries
import time 



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
import yfinance as yf


msft = yf.Ticker('MSFT')
#print(msft)

#print(msft.previousClose)

print(msft.history(period='max'))
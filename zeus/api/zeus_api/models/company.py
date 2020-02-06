

class Company(object):
    # TODO: Company needs all the properties from whiteboard drawings from last meeting
    def __init__(self, Ticker):
        self.ticker = Ticker  # stock symbol is called a ticker
    # TODO: all models must utalize handler module to perform writing and retrieving data from database

    def update(self):
        # this function will update the model to its proper collection
        pass

    def read(self):
        # this function will read a specified model from its proper collection
        pass

    def get_ticker(self):
        if self.ticker:
            return self.ticker  # if the ticker exists then return the ticker
        else:
            return 'None'  # return none string not None object

    def serialize(self):
        return {
            'ticker': self.ticker
        }

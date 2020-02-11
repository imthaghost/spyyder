

class Graph(object):
    # TODO: Graph needs all the properties from whiteboard drawings from last meeting
    def __init__(self, prediction, current_price, sell_stock, buy_stock, data):
        self.prediction = prediction
        self.current_price = current_price
        self.sell_stock = sell_stock
        self.buy_stock = buy_stock
        self.data = data
        
    # TODO: all models must utalize handler module to perform writing and retrieving data from database

    def graph_prediction(self):
        #predicts stock data
        return self.prediction

    def graph_current_price(self):
        #sets the graphs current price
        return self.current_price

    def graph_sell_stock(self):
        #returns when the user should sell stock
        return self.sell_stock

    def graph_buy_stock(self):
        #returns when the user should buy stock
        return self.buy_stock

    def graph_data(self):
        #displays graph data
        if self.data:
            return self.data
        else:
            return 'No data available at the moment.'
    
    def update(self):
        # this function will update the model to its proper collection
        pass

    def read(self):
        # this function will read a specified model from its proper collection
        pass

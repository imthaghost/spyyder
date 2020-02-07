
from zeus_api.models.graph import Graph


class Company(object):
    def __init__(self, name):
        self.name = name  # company name
        self.description = dict()  # key value pairs of company
        self.ticker = None  # stock symbol is called a ticker
        self.news = None  # some data structure will be needed to store news
        self.total_shares = None  # integer value
        self.category = None  # some string value
        self.risk_level = None  # some string value
        self.graph = Graph  # Graph instance
        # todo clicks will be a histogram like datastrucure that stores userID -> clicks
        self.clicks = None


######################### getters ############################################


    def get_ticker(self):
        # return company ticker
        return self.ticker

    def get_description(self):
        # return company description
        return self.description

    def get_news(self):
        # return company news
        return self.news

    def get_total_shares(self):
        # return company total shares
        return self.total_shares

    def get_category(self):
        # return company category
        return self.category

    def get_risk_level(self):
        # reutn company risk level
        return self.risk_level

    def get_graph(self):
        # return company graph object
        return self.graph

    def get_clicks(self):
        # return histogram object of all user clicks of this object
        return self.clicks
###################### setters ###################################################

    def set_ticker(self):
        # todo sets company ticker value
        pass

    def set_description(self):
        # todo sets company description value
        pass

    def set_news(self):
        # todo sets company news value
        pass

    def set_total_shares(self):
        # todo sets company total shares value
        pass

    def set_category(self):
        # todo sets company category value
        pass

    def set_risk_level(self):
        # todo sets company risk level value
        pass
################## company object helper functions ######################################
# TODO: all models must utalize handler module to perform writing and retrieving data from database

    def serialize(self):
        # todo returns all object instance variables in json format
        pass

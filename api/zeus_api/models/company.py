import uuid
# local python modules
from zeus_api.models.graph import Graph
from zeus_api.models.handler import Handler


class Company(Handler):
    def __init__(self, name):
        self.stockprice = None
        self.logo = None
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
        self.volume = None


################## company object helper functions ######################################
# TODO: all models must utalize handler module to perform writing and retrieving data from database

    def set_uuid(self):
        self.uuid = str(uuid.uuid4())

    def serialize(self):
        return {
            "logo": self.logo,
            "price": self.stockprice,
            "name": self.name,
            "description": self.description,
            "ticker": self.ticker,
            "totalshares": self.total_shares,
            "news": self.news
        }

    def save_new(self):
        # todo refactor to make more DRY for all Models
        # todo generate a token and sent to users email
        # saves new user to database
        zeus_api.user.insert_one(self.serialize())

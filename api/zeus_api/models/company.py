

class Company(object):
    # TODO: Company needs all the properties from whiteboard drawings from last meeting
    def __init__(self, Ticker, headline, total_share, category, name, risk_level):
        self.ticker = Ticker  # stock symbol is called a ticker
        self.headline = headline
        self.total_share = total_share
        self.category = category
        self.name = name
        self.risk_level = risk_level
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

    def headlines(self):
        if self.headline:
            return {
                'Headline' : self.headline
            }
        else:
            return 'No headlines'

    def total_shares(self):
        return {
            'Shares' : self.total_share
        }

    def get_graph(self):
        pass

    def company_category(self):
        if self.company_category:
            return {
                'Category' : self.company_category
            }
        else:
            return 'N/A'


    def company_name(self):
        return {
            'Company Name' : self.name
        }

    def get_risk_level(self):
        if self.risk_level:
            return {
                'Risk Level' :self.risk_level
            }
        else:
            return 'N/A'

    def serialize(self):
        return {
            'ticker': self.ticker
        }


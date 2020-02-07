

class User(object):
    # TODO: Company needs all the properties from whiteboard drawings from last meeting
    def __init__(self, premium, portfolio, name, identification, investor_type, email='None', password='None'):
        # password is not required because a user can sign up with OAUTH
        self.premium = premium
        self.portfolio = portfolio
        self.name = name
        self.identification = identification
        self.investor_type = investor_type
        self.email = email  # email will be the username
        

    def get_email(self):
        return self.email

    def serialize(self):
        return {
            'email': self.email
        }

    def is_premium(self):
        if self.premium:
            return self.premium
        else:
            return 'Upgrade to Premium for more features'
    # TODO: all models must utalize handler module to perform writing and retrieving data from database
    
    def has_portfolio(self):
        if self.portfolio:
            return self.portfolio
        else: 
            return 'Your portfolio is empty'
    
    def user_identification(self):
        return self.identification

    def user_investor_type(self):
        return self.investor_type

    def user_name(self):
        return {
            'Name' : self.name
        }
        
    def update(self):
        pass

    def read(self):
        pass
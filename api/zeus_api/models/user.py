"""User Model"""
# built in python modules

# external python modules
import uuid
# local python modules
from zeus_api.models.company import Company
import zeus_api


class User(object):
    def __init__(self, full_name, email='None', password='None'):
        self.full_name = full_name  # users full name
        # password is not required because a user can sign up with OAUTH
        self.premium = False  # intialize premium to false
        self.portfolio = [Company]  # user porfolio is a list of companies
        self.uuid = None  # initalize no uuid
        self.investor_type = None  # initialize the investor type to None
        self.email = email  # email will be the username
        self.password = password  # set password

################ getters #########################

    def get_email(self):
        # get user email
        return self.email

    def get_is_premium(self):
        # get user subscription status
        return self.premium

    def get_portforlio(self):
        # returns a list of Companies
        return self.portfolio

    def get_investor_type(self):
        # returns type of investor
        return self.investor_type

    def get_uuid(self):
        # returns uuid
        return self.uuid

################ setters #########################
    def set_uuid(self):
        self.uuid = str(uuid.uuid4())
################ user model helper functions #######################

    def serialize(self):
        # serialize user details
        return {
            'email': self.email,
            'uuid': self.uuid,
            'password': self.password,
            'fullname': self.full_name
        }

    def save_new(self):
        # todo refactor to make more DRY for all Models
        # todo generate a token and sent to users email
        # saves new user to database
        zeus_api.user.insert_one(self.serialize())

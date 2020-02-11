"""User Model"""
# built in python modules

# external python modules
import uuid
# local python modules
import zeus_api


class User(object):
    def __init__(self, full_name, email='None', password='None'):
        self.full_name = full_name  # users full name
        # password is not required because a user can sign up with OAUTH
        self.premium = False  # intialize premium to false
        # user porfolio is a list of companies
        self.portfolio = [zeus_api.models.company.Company]
        self.uuid = None  # initalize no uuid
        self.investor_type = None  # initialize the investor type to None
        self.email = email  # email will be the username
        self.password = password  # set password
        self.phonenumber = None  # user phone number

    def set_uuid(self):
        self.uuid = str(uuid.uuid4())

    def serialize(self):
        # serialize user details
        return {
            "email": self.email,
            "uuid": self.uuid,
            "password": self.password,
            "fullname": self.full_name,
            "premium": self.premium,
            "investor_type": self.investor_type,
            "portfolio": self.portfolio,
            "phonenumber":  self.phonenumber
        }

    def save_new(self):
        # todo refactor to make more DRY for all Models
        # todo generate a token and sent to users email
        # saves new user to database
        zeus_api.user.insert_one(self.serialize())

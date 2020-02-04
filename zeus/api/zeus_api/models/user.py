

class User(object):
    # TODO: Company needs all the properties from whiteboard drawings from last meeting
    def __init__(self, email='None', password='None'):
        # password is not required because a user can sign up with OAUTH
        self.email = email  # email will be the username

    def get_email(self):
        return self.email

    def serialize(self):
        return {
            'email': self.email
        }

    # TODO: all models must utalize handler module to perform writing and retrieving data from database

    def update(self):
        pass

    def read(self):
        pass

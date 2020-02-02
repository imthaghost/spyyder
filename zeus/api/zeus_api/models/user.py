class User(object):
    def __init__(self, email='None', password='None'):
        # password is not required because a user can sign up with OAUTH
        self.email = email  # email will be the username

    def get_email(self):
        return self.email

    def json(self):
        return {
            'email': self.email
        }

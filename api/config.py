import os
from dotenv import load_dotenv
load_dotenv()

basedir = os.path.abspath(os.path.dirname(__file__))
DATABASE_URL = os.getenv('DATABASE_URL')


class Config(object):
    DEBUG = False  # debug mode
    TESTING = False  # testing mode
    CSRF_ENABLED = True  # CSRF prevention
    SECRET_KEY = os.getenv('secret_key')  # server secret
    MONGODB_URI = DATABASE_URL  # mongodb url
    #### google secrets ####
    GOOGLE_CLIENT_ID = os.environ.get(os.getenv('google_client_id'))
    GOOGLE_CLIENT_SECRET = os.environ.get(os.getenv('google_client_secret'))


class ProductionConfig(Config):
    DEBUG = False


class StagingConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class TestingConfig(Config):
    TESTING = True

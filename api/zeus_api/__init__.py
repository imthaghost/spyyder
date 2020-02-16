# built-in python modules
import os
# external python modules
from flask import Flask, render_template, redirect, jsonify
from flask_session import Session
from pymongo import MongoClient
from dotenv import load_dotenv
from flask_restful import Api
# local controller modules
from zeus_api.controllers.company_details import companyDetails
from zeus_api.controllers.user_details import User_details
from zeus_api.controllers.tester import grabber, wipe, up
from zeus_api.controllers.login import authenticate
from zeus_api.controllers.create_user import create
from zeus_api.controllers.email import Email
from zeus_api.controllers.subscriptions import Subscribe
# load enviornment variables
load_dotenv()
# application instantiation
app = Flask("api")
# api instantiation
api = Api(app)
# allow sessions
sess = Session()
# init session object
sess.init_app(app)
# application configuration from .env file
app.config.from_object(os.getenv('APP_SETTINGS'))
# try to set mongo database
try:
    client = MongoClient(host=os.getenv('DATABASE_URL'))
except Exception as error:
    print(error)
# instantiate and get default db name
db = client.get_default_database()
# vistitor collection
visitor = db.visitor
# user collection
user = db.user
# company collection
company = db.company
# graph collection
graph = db.graph
# user subscription collection
subscribers = db.subscriptions
########### subscription enpoints ################
api.add_resource(Subscribe, '/subscribe')
########### ds enpoints ##################
api.add_resource(companyDetails, '/company')
########### user enpoints ##################
api.add_resource(User_details, '/user')
api.add_resource(create, '/create')
############## authentication endpoints ###############
api.add_resource(authenticate, '/login')
api.add_resource(Email, '/email')
############### test endpoints #####################
api.add_resource(grabber, '/grabber')
api.add_resource(up, '/up')
# !  be careful wipes all users from database this will not be in production obviously
api.add_resource(wipe, '/wipe')

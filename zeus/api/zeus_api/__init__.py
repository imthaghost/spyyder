# built-in python modules
import os
# external python modules
from flask import Flask, render_template, redirect, jsonify
from pymongo import MongoClient
from flask_restful import Api
from dotenv import load_dotenv
# local controller modules
from zeus_api.controllers.token_auth import tokenAuth, grabber, up
from zeus_api.controllers.user_details import User_details
from zeus_api.controllers.company_details import companyDetails
from zeus_api.controllers.login import authenticate


# load enviornment variables
load_dotenv()
# application instantiation
app = Flask("api")
# api instantiation
api = Api(app)
# application configuration from .env file
app.config.from_object(os.getenv('APP_SETTINGS'))
# try to set mongo database
try:
    client = MongoClient(host=os.getenv('DATABASE_URL'))
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
except Exception as error:
    print(error)
# instantiate resource endpoints
api.add_resource(tokenAuth, '/token')
api.add_resource(User_details, '/user/<userid>')
api.add_resource(companyDetails, '/company/<companyid>')
api.add_resource(authenticate, '/login')
api.add_resource(grabber, '/grabber')
api.add_resource(up, '/up')

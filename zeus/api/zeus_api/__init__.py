from flask import Flask, render_template, redirect, jsonify
from flask_restful import Api
from zeus_api.controllers.token_auth import tokenAuth
from zeus_api.controllers.user_details import User_details
from pymongo import MongoClient
import os
from dotenv import load_dotenv
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

api.add_resource(tokenAuth, '/token')
api.add_resource(User_details, '/user/<userid>')

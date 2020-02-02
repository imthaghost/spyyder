from flask import Flask, render_template, redirect, jsonify
from zeus_api.controllers.token_auth import tk_auth
from pymongo import MongoClient
import os
from dotenv import load_dotenv
load_dotenv()

app = Flask(__name__)
app.config.from_object(os.getenv('APP_SETTINGS'))

try:
    client = MongoClient(host=os.getenv('DATABASE_URL'))
    db = client.get_default_database()
    visitor = db.visitor
except Exception as error:
    print(error)

app.register_blueprint(tk_auth)

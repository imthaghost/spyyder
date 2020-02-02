from flask import Flask, render_template, redirect, jsonify
from flask_sqlalchemy import SQLAlchemy
import os
from random import randint
from server.controllers.token_auth import authentication

app = Flask('api')
app.config.from_object(os.environ['APP_SETTINGS'])
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)


app.register_blueprint(authentication)

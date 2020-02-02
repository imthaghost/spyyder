from flask import Flask, render_template, redirect, jsonify
from zeus_api.controllers.token_auth import tk_auth
from flask_sqlalchemy import SQLAlchemy
import os

app = Flask('apiserver')
app.config.from_object(os.environ['APP_SETTINGS'])
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

try:
    database = SQLAlchemy(app)
except Exception as error:
    print(error)


app.register_blueprint(tk_auth)

from flask import Flask, render_template, redirect, jsonify
from flask_sqlalchemy import SQLAlchemy
import os
from random import randint

app = Flask(__name__)
app.config.from_object(os.environ['APP_SETTINGS'])
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
try:
    import models
except ImportError as e:
    print(e)


@app.route('/')
@app.route('/index', methods=['GET', 'POST'])
def home():
    return "Home"


@app.route('/token')
def gen():

    r = models.Result(url=randint(0, 20), result_all=None,
                      result_no_stop_words=None)
    db.session.add(r)
    db.session.commit()
    return jsonify({'token': r.url})


if __name__ == "__main__":
    app.run(port='5000')

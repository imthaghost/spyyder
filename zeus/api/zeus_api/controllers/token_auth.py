"""Authentication route"""

from flask import jsonify, Blueprint
from random import randint
import json

from zeus_api.models.user import User
import zeus_api

tk_auth = Blueprint('token', __name__)


@tk_auth.route('/token')
def auth():
    # user = User(email=randint(0, 300))
    # data = user.serialize()
    # zeus_api.visitor.insert_one(json.loads(json.dumps(data)))
    data = randint(0, 900)
    return jsonify({'token': data})

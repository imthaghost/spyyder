"""Authentication route"""

from flask import jsonify, Blueprint
from random import randint

from zeus_api.models.user import User

tk_auth = Blueprint('token', __name__)


@tk_auth.route('/token')
def auth():

    user = User(email=randint(0, 300))
    data = user.json()
    return jsonify({'token': data})

"""Authentication route"""

from flask import jsonify, Blueprint
from random import randint
try:
    from zeus_api.models.result_model import Result
    import zeus_api
except Exception as e:
    print(e)

tk_auth = Blueprint('token', __name__)


@tk_auth.route('/token')
def auth():

    r = Result(url=randint(0, 20), result_all=None,
               result_no_stop_words=None)
    zeus_api.database.session.add(r)
    zeus_api.database.session.commit()
    return jsonify({'token': r.url})

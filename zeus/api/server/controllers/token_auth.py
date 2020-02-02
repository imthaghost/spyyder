"""Authentication route"""

from flask import jsonify, Blueprint
try:
    from server.models import result_model
except Exception as e:
    print(e)

authentication = Blueprint('token', __name__)


@authentication.route('/token')
def auth():

    r = result_model.Result(url=randint(0, 20), result_all=None,
                            result_no_stop_words=None)
    db.session.add(r)
    db.session.commit()
    return jsonify({'token': r.url})

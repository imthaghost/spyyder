from sqlalchemy.dialects.postgresql import JSON

try:
    from server import db
except Exception as e:
    print(e)


class Result(db.Model):
    __tablename__ = 'results'
    id = db.Column(server.db.Integer, primary_key=True)
    url = db.Column(server.db.String())
    result_all = db.Column(JSON)
    result_no_stop_words = db.Column(JSON)

    def __init__(self, url, result_all, result_no_stop_words):
        self.url = url
        self.result_all = result_all
        self.result_no_stop_words = result_no_stop_words

    def __repr__(self):
        return '<id {}>'.format(self.id)

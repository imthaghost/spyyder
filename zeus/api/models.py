import server
from sqlalchemy.dialects.postgresql import JSON


class Result(server.db.Model):
    __tablename__ = 'results'

    id = server.db.Column(server.db.Integer, primary_key=True)
    url = server.db.Column(server.db.String())
    result_all = server.db.Column(JSON)
    result_no_stop_words = server.db.Column(JSON)

    def __init__(self, url, result_all, result_no_stop_words):
        self.url = url
        self.result_all = result_all
        self.result_no_stop_words = result_no_stop_words

    def __repr__(self):
        return '<id {}>'.format(self.id)

from sqlalchemy.dialects.postgresql import JSON

try:
    import zeus_api
    # import .zeus_api
except Exception as e:
    print("result error: ", e)


class Result(zeus_api.database.Model):
    __tablename__ = 'results'
    id = zeus_api.database.Column(zeus_api.database.Integer, primary_key=True)
    url = zeus_api.database.Column(zeus_api.database.String())
    result_all = zeus_api.database.Column(JSON)
    result_no_stop_words = zeus_api.database.Column(JSON)

    def __init__(self, url, result_all, result_no_stop_words):
        self.url = url
        self.result_all = result_all
        self.result_no_stop_words = result_no_stop_words

    def __repr__(self):
        return '<id {}>'.format(self.id)

from flask import session, render_template, request, redirect, Blueprint


home = Blueprint('index', __name__, static_folder='static')


@home.route('/')
@home.route('/index', methods=['GET', 'POST'])
def index():
        #take the user to the home page
    if request.method == 'GET':
        return render_template('index.html')

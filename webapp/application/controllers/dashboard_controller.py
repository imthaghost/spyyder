from flask import session, render_template, request, redirect, Blueprint, url_for


dashboard = Blueprint('dashboard', __name__, static_folder='static')


@dashboard.route('/dashboard', methods=['GET'])
def root():
    if request.method == 'GET':
        if 'user' in session:

            return render_template('trending.html')
        else:

            return redirect(url_for('index.index'))

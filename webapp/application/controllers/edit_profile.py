from flask import session, render_template, request, redirect, Blueprint


edit = Blueprint('edit', __name__, static_folder='static')


@edit.route('/edit', methods=['GET'])
def root():
    if request.method == 'GET':
        if 'user' in session:
            user_data = session['user']
            print(user_data)
            return render_template('edit_profile.html', user_data=user_data)
        else:
            # take user to home page
            return render_template('index.html')

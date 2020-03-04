from flask import session, render_template, request, redirect, Blueprint, url_for
import requests
import json
from bson import json_util


login = Blueprint('login', __name__, static_folder='static')


@login.route('/login', methods=['GET', 'POST'])
def root():
    if request.method == 'GET':
        if 'user' in session:
            return render_template('trending.html')
        else:
            # take user to home page
            return render_template('login.html')
    if request.method == 'POST':
        # get users email from user input
        email = request.form.get('email')
        pw = request.form.get('password')
        # get users first name from user inpu
        LOGIN_ENDPOINT = 'http://0.0.0.0:8000/login'
        LOGIN_PARAMS = {'email': email, 'password': pw}
        l = requests.post(url=LOGIN_ENDPOINT, json=LOGIN_PARAMS)
        if l.status_code == 200:
            token = l.json()['token']
            # post token to user detail endpoint and create a session
            headers = {'content-type': 'application/json', 'token': token}

            USER_DETAIL_ENPOINT = 'http://0.0.0.0:8000/user'
            x = requests.get(url=USER_DETAIL_ENPOINT, headers=headers)
            data = x.json()['success']
            user_data = {
                'email':  data['email'],
                'fullname': data['fullname'],
                'premium':  data['premium'],
                'uuid': data['uuid'],
                'token': token
            }
            print(token)
            print(user_data)
            session['user'] = json.loads(json_util.dumps(user_data))
            return redirect(url_for('dashboard.root'))
        else:
            return redirect(url_for('index.index'))

    else:
        return render_template('login.html')

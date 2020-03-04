from flask import url_for, render_template, request, redirect, Blueprint, jsonify, session
import json
import requests
from bson import json_util

signup = Blueprint('signup', __name__, static_folder='static')


@signup.route('/signup', methods=['POST'])
def root():

    if request.method == 'POST':
        # get users email from user input
        full_name = request.form.get('fullname')
        email = request.form.get('email')
        pw = request.form.get('password')
        # get users first name from user input
        first_name = request.form.get('firstname')
        # create a user
        CREATE_ENDPOINT = 'http://0.0.0.0:8000/create'
        # params to send to api
        PARAMS = {'email': email, 'fullname': full_name, 'password': pw}
        r = requests.post(url=CREATE_ENDPOINT, json=PARAMS)
        # if the request is valid with the new credentials log the user in and grab token
        if r.status_code == 200:
            LOGIN_ENDPOINT = 'http://0.0.0.0:8000/login'
            LOGIN_PARAMS = {'email': email, 'password': pw}
            l = requests.post(url=LOGIN_ENDPOINT, json=LOGIN_PARAMS)
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
            session['user'] = json.loads(json_util.dumps(user_data))

        return redirect(url_for('index.index'))
    else:
        return render_template('index.html')

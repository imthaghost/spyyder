from flask import url_for ,render_template, request, redirect, Blueprint, jsonify
import json
import requests

email_route = Blueprint('email', __name__, static_folder='static')


@email_route.route('/email', methods=['GET', 'POST'])
def email():

    if request.method == 'POST':
        email = request.form.get('email')
        first_name = request.form.get('firstname')
        # url for api
        API_ENDPOINT = 'http://0.0.0.0:8000/subscribe'
        # params to send to api
        PARAMS = {'email':email, 'firstname': first_name} 

        r = requests.post(url = API_ENDPOINT, json = PARAMS) 
        
        print(r)


        return redirect(url_for('index.index'))
    else:
        return render_template('index.html')

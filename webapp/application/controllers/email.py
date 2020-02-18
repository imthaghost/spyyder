from flask import session, render_template, request, redirect, Blueprint, jsonify
import json

email_route = Blueprint('email', __name__, static_folder='static')


@email_route.route('/email', methods=['GET', 'POST'])
def email():
    #if statement to add each email and first name to the database
    if request.method == 'POST':
        email = request.form.get('email')
        first_name = request.form.get('firstname')

        #return the email and first name of each user
        return jsonify({'email': email, 'first_name': first_name})
    else:
        return render_template('index.html')

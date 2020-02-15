from flask import session, render_template, request, redirect, Blueprint, jsonify
import json

email_page = Blueprint('index', __name__, static_folder='static')


@email_page.route('/email', methods=['GET', 'POST'])
def get_email():
    
     email_user = {}

    if request.method == 'POST':
        email_user = user.insert_one({'email': request.form['email']})

    return jsonify({'email': "You're on the waitlist!"})
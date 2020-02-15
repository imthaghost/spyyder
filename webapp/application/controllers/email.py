from flask import session, render_template, request, redirect, Blueprint, jsonify
import json

email_route = Blueprint('email', __name__, static_folder='static')


@email_route.route('/email', methods=['GET', 'POST'])
def email():

    if request.method == 'POST':
        email = request.form.get('email')
        return jsonify({'email': email})
    else:
        return render_template('index.html')

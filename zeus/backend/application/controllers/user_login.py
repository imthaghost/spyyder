# """
# login route blueprint
# """
# # built-in modules
# import os

# # external Python Modules
# from flask import session, send_file, render_template, redirect, url_for, flash, Blueprint, request
# from bson import json_util
# import bcrypt
# import json
# import app


# # create Blue print for login route
# login_route = Blueprint('login_route', __name__, static_folder='static')


# @login_route.route('/login', methods=['GET', 'POST'])
# def login():
#     if 'user' in session:
#         return redirect(url_for('dashboard.dashboard'))
#     else:
#         if request.method == 'GET':
#             return render_template('login.html')
#         if request.method == 'POST':
#             email_field = request.form.get('email')
#             password_field = request.form.get('password')
#             login_user = app.user.find_one({'email': email_field})
#             if login_user:
#                 if bcrypt.hashpw(password_field.encode('utf-8'), login_user['password']) == login_user['password']:
#                     # set up session
#                     data = {
#                         'email': login_user['email'],
#                         'id': login_user['_id'],
#                         'created': login_user['created_at'],
#                         'ip': login_user['client_ip'],
#                         'interests': login_user['interests'],
#                         'projects': login_user['projects'],
#                         'full_name': login_user['full_name']
#                     }
#                     session['user'] = json.loads(json_util.dumps(data))

#                     return redirect(url_for('dashboard.dashboard'))
#                 else:
#                     return render_template('login.html')
#             else:
#                 return render_template('login.html')
from flask import session, render_template, request, redirect, Blueprint


login_route = Blueprint('login', __name__, static_folder='static')


@login_route.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template('login.html')

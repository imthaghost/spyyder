from application.controllers.home import home
from application.controllers.user_login import login_route
from flask import Flask, request

app = Flask("digift", template_folder='application/templates',
            static_folder='application/static')
app.register_blueprint(home)
app.register_blueprint(login_route)

@app.route('/email', methods=['GET', 'POST'])
def get_email():
    
     email_user = {}

    if request.method == 'POST':
        email_user = user.insert_one({'email': request.form['email']})

    return 
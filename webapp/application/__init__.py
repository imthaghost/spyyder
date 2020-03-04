import os
from application.controllers.home import home
#from application.controllers.email import email_route
from application.controllers.dashboard_controller import dashboard
from application.controllers.signup import signup
from application.controllers.logout import logout
from application.controllers.login import login
from application.controllers.user_profile import profile
from application.controllers.edit_profile import edit
from application.controllers.company_detail import company_detail
from flask import Flask, request

app = Flask("spyyder", template_folder='application/templates',
            static_folder='application/static')

app.config['SECRET_KEY'] = os.urandom(24)  # change later

app.register_blueprint(home)
app.register_blueprint(dashboard)
app.register_blueprint(signup)
app.register_blueprint(logout)
app.register_blueprint(login)
app.register_blueprint(profile)
app.register_blueprint(edit)
app.register_blueprint(company_detail)

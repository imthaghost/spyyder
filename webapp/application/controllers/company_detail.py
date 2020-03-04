from flask import url_for, render_template, request, redirect, Blueprint, jsonify, session
import json
import requests
from bson import json_util

company_detail = Blueprint('company_detail', __name__, static_folder='static')


# @company_detail.route('/company/<company_id>', methods=['POST'])
# def project_show(company_id):
#     """ Show a single company view
#     """
#     if 'user' in session:
#         user_data = session['user']
#         # {%- for project in project_list %}
#        # {%- endfor -%}
#         # {%- endif -%}
#         #company = app.projects.find_one({'_id': ObjectId(company_id)})
#         return render_template('company.html', user_data=user_data)

@company_detail.route('/company', methods=['GET'])
def root():
    """ Show a single company view
    """
    if 'user' in session:
        user_data = session['user']
        # {%- for project in project_list %}
       # {%- endfor -%}
        # {%- endif -%}
        #company = app.projects.find_one({'_id': ObjectId(company_id)})
        return render_template('company.html', user_data=user_data)

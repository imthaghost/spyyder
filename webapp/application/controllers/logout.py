from flask import url_for, render_template, request, redirect, Blueprint, jsonify, session


logout = Blueprint('logout', __name__, static_folder='static')


@logout.route('/logout')
def root():

    session.clear()
    return redirect(url_for('index.index'))

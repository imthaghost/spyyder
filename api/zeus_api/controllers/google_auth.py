# built in python modules
import sys
import os
# external python modules
from flask import Blueprint, request, redirect, jsonify
from oauthlib.oauth2 import WebApplicationClient
import requests
# local python modules
import zeus_api
# google auth route initialization
google_auth = Blueprint('google_auth', __name__, static_folder='static')
# google discovery endpoint
GOOGLE_DISCOVERY_URL = (
    "https://accounts.google.com/.well-known/openid-configuration")


def get_google_provider_cfg():
    # response from discovery endpoint
    return requests.get(GOOGLE_DISCOVERY_URL).json()


@google_auth.route("/google")
def google():
    # find out what URL to hit for Google login
    google_provider_cfg = get_google_provider_cfg()
    authorization_endpoint = google_provider_cfg["authorization_endpoint"]

    # scopes that let you retrieve user's profile from Google
    request_uri = auth.prepare_request_uri(
        authorization_endpoint,
        redirect_uri=request.base_url + "/callback",
        scope=["openid", "email", "profile"],
    )
    return redirect(request_uri)


@google_auth.route("/google/callback")
def callback():
    # Get authorization code Google sent back
    code = request.args.get("code")
    print("This is the access token: ", code)
    # Find out what URL to hit to get tokens that allow you to ask for things on behalf of a user
    google_provider_cfg = get_google_provider_cfg()
    token_endpoint = google_provider_cfg["token_endpoint"]
    # Prepare and send a request to get tokens
    token_url, headers, body = auth.prepare_token_request(
        token_endpoint,
        authorization_response=request.url,
        redirect_url=request.base_url,
        code=code
    )
    token_response = requests.post(
        token_url,
        headers=headers,
        data=body,
        auth=(GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET),
    )
    # Parse the fucking tokens!
    auth.parse_request_body_response(json.dumps(token_response.json()))
    # user's profile information, including their Google profile image and email
    userinfo_endpoint = google_provider_cfg["userinfo_endpoint"]
    uri, headers, body = auth.add_token(userinfo_endpoint)
    # lets grab that user infos
    userinfo_response = requests.get(uri, headers=headers, data=body)
    # quick sanity check before accessing data
    if userinfo_response.json().get("email_verified"):
        unique_id = userinfo_response.json()["sub"]
        users_email = userinfo_response.json()["email"]
        picture = userinfo_response.json()["picture"]
        users_name = userinfo_response.json()["given_name"]
    else:
        return "User email not available or not verified by Google.", 400
    # check to see if the user exists in the database
    current_user = zeus_api.user.find_one({'email': users_email})
    if current_user:
        # todo Begin user session by logging the user in
        #session['user'] = json.loads(json_util.dumps(data))
        # todo return JSON JWT token
        return jsonify({'message': 'success'})
    else:
        new_user = User(email=users_email)
        new_user.server_ip = request.remote_addr
        new_user.client_ip = request.environ.get(
            'HTTP_X_FORWARDED_FOR')
        # insert new user collection to data base
        current_user = zeus_api.user.insert({'email': users_email})
        # todo Begin user session by logging the user in
        # session['user'] = json.loads(json_util.dumps(data))
        # todo send JSON JWT token
        return jsonify({'message': 'user didnt exist user created'})

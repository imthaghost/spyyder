# built in python modules
import smtplib
from socket import error as socket_error
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import os
# external python modules
from flask import jsonify, request
from flask_restful import Resource
import dkim

# local python modules
import zeus_api

# configurations
debug_level = 3  # SMTP debug mode
sender_domain = 'digift.com'  # sender domain
company_email = 'no-reply@digift.com'  # company email
# dkim signature path
dkim_private_key_path = os.getenv('private_key_path')
dkim_selector_path = ""  # dkim selector path
subject = 'Thanks for subscriibing'
body = "Thanks"


def send_email(
    to_email,
    sender_email,
    subject,
    message_text,
    message_html=None,
    relay="localhost",
    dkim_private_key_path="",
    dkim_selector="",
):
    sender_domain = sender_email.split("@")[-1]
    msg = MIMEMultipart("alternative")
    msg.attach(MIMEText(message_text, "plain"))
    #msg.attach(MIMEText(message_html, "html"))
    msg["To"] = to_email
    msg["From"] = sender_email
    msg["Subject"] = subject

    if dkim_private_key_path and dkim_selector:
        with open(dkim_private_key_path) as fh:
            dkim_private_key = fh.read()
        headers = ["To", "From", "Subject"]
        sig = dkim.sign(
            message=msg.as_string(),
            selector=str(dkim_selector),
            domain=sender_domain,
            privkey=dkim_private_key,
            include_headers=headers,
        )
        msg["DKIM-Signature"] = sig.lstrip("DKIM-Signature: ")

    # TODO: react if connecting to postfix is a socket error.
    s = smtplib.SMTP(relay)
    s.sendmail(sender_email, [to_email], msg.as_string())
    s.quit()
    return msg


class Subscribe(Resource):
    def get(self):
        return jsonify({'message': 'method not allowed'})

    def post(self):
        data = request.get_json()
        if data:
            email = data.get('email')
            first_name = data.get('firstname')
            # serialized data
            subscribers = {
                'email': email,
                'firstname': first_name
            }
            to_email = email
            x = send_email(to_email, company_email, subject, body,
                           dkim_private_key_path=dkim_private_key_path, dkim_selector=dkim_selector_path)
            print(x)
            # insert person into database
            zeus_api.subscribers.insert_one(subscribers)
            return jsonify({'message': 'Thanks for subscribing'})
        else:
            return jsonify({'message': 'empty requests'})

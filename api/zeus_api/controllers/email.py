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


class Email(Resource):
    def post(self):
        data = request.get_json()
        # grab email key
        to_email = data.get('email')
        x = send_email(to_email, company_email, subject, body,
                       dkim_private_key_path=dkim_private_key_path, dkim_selector=dkim_selector_path)
        # # start email credentials to send over to
        # # sender_domain = sender_email.split("@")[-1]
        # msg = MIMEMultipart("alternative")
        # message_text = "Thanks for subscribing"
        # # type of email to send
        # msg.attach(MIMEText(message_text, "plain"))
        # #msg.attach(MIMEText(message_html, "html"))
        # # email to user
        # msg["To"] = to_email
        # # from email
        # msg["From"] = company_email
        # # email subject
        # msg["Subject"] = 'Subscription'
        # # nontype check for dkim signature path
        # # read the private key file
        # with open(dkim_private_key_path) as fh:
        #     key = fh.read()
        #     # setup the headers
        #     headers = ["To", "From", "Subject"]
        #     # sign the message
        #     sig = dkim.sign(
        #         message=msg.as_string(),
        #         selector=dkim_selector,
        #         domain=sender_domain,
        #         privkey=key,
        #         include_headers=headers)
        #     msg["DKIM-Signature"] = sig.lstrip("DKIM-Signature: ")

        # # TODO: react if connecting to postfix is a socket error.
        # s = smtplib.SMTP(relay)
        # server.set_debuglevel(debug_level)
        # s.sendmail(sender_email, [to_email], msg.as_string())
        # s.quit()
        return jsonify({'response': str(x)})
#!################################ Gmail Connection ###########################################
    # server = {
    #     'gmail': 'smtp.gmail.com',  # gmail smtp server
    # }
    # # SSL connection port numbers
    # SSL_ports = {"lower_port": 465, "high_port": 25025}
    # # log debug level
    # debug_level = 3
    # # generic email string
    # mail_content = """Thank you for subscribing to our newsletter :) """

    # try:
    #     server = SMTP(server['gmail'], SSL_ports['lower_port'])
    #     # set the debug level
    #     server.set_debuglevel(debug_level)
    #     # identify ourselves to smtp gmail client

    #     username = os.environ['email']
    #     password = os.environ['email_password']
    #     receiver = request.form['email']
    #     message = MIMEMultipart()
    #     message['From'] = username
    #     message['To'] = receiver
    #     # The subject line
    #     message['Subject'] = '(Important) E-store NewsLetter'
    #     # The body and the attachments for the mail
    #     message.attach(MIMEText(mail_content, 'plain'))
    #     sys.stdout.write('\x1b[1;32m' + receiver + '\x1b[0m' + '\n')
    #     server.ehlo()
    #     server.login(username, password)
    #     text = message.as_string()
    #     sys.stdout.write(
    #         '\x1b[1;32m' + " [+] Connection successful" + '\x1b[0m' + '\n')

    #     server.sendmail(username, receiver, text)
    #     server.close()

    # except:
    #     sys.stdout.write(" [x] Connection Failed")
    # return redirect(url_for('index'))
#!################################ Gmail Connection ###########################################

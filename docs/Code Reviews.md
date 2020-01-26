# Code Reviews

# Philosophy

We do code reviews so that we make sure that the code written can be seen from a different perspective. Everyone has a different way of completing something, gaining insight from another person is always a great for learning.

# Preparing Code for Review

Preparation sets your reviewers up for success.

### Commit Messages

Make sure your commit messages are descriptive. Commit messages should be in the form of the action you are doing surrounded by brackets and the the description. For example:

    [update] fixed inifinite loop in login function

### Github Pull Request Descriptions

Your PR descriptions should be an extension of your commit messages. Write about both what the commit changes, and how you implemented the change. 

    Each time a user tried to login the login function would constantly
    check with the database to see if the user existed and did not break out. 
    Causeing an infinit loop. I have created a base case and now the loop ends when
    the user is found.

# Performing Code Reviews

### How to Review

- Make two passes over the PR if it's substantial.
    - On the first pass, come to an understanding of the code change at a high level.
    - On the second pass, pay more attention to semantic details.

# Examples

    @github_route.route('/github/callback')
    @github.authorized_handler
    def authorized(oauth_token):
        next_url = request.args.get('next') or url_for('dashboard.dashboard')
        if oauth_token is None:
            flash("Authorization failed.")
            print(failed)
            return redirect(next_url)
    
        g = GitAPI(oauth_token)
        git_user = g.get_user()
        email = git_user.email
        # if the user is found set up a session and redirect index route
        if user.find_one({'email': email}):
            # this is a user who has already registerd
            current_user = user.find_one({'email': email})
            data = {
                'email': current_user['email'],
                'id': current_user['_id'],
                'created': current_user['created_at'],
                'ip': current_user['client_ip'],
                'interests': current_user['interests'],
                'github_access_token': current_user['github_access_token'],
                'projects': current_user['projects'],
                'full_name': current_user['full_name']
            }
            # Begin user session by logging the user in
            session['user'] = json.loads(json_util.dumps(data))
            # redirect to index route where the home page will be rendered for user session
            return redirect(next_url)
        else:
            g = GitAPI(oauth_token)
            git_user = g.get_user()
            # create a new User
            new_user = User(email=git_user.email)
            new_user.github_access_token = oauth_token
            new_user.full_name = git_user.name
            new_user.server_ip = request.remote_addr
            new_user.client_ip = request.environ.get(
                'HTTP_X_FORWARDED_FOR')
            # insert new user collection to data base
            user_id = user.insert_one(new_user.json()).inserted_id
            # define current user as the new collection
            current_user = user.find_one({'github_access_token': oauth_token})
            # model for persistent data
            data = {
                'email': current_user['email'],
                'id': current_user['_id'],
                'created': current_user['created_at'],
                'ip': current_user['client_ip'],
                'interests': current_user['interests'],
                'github_access_token': current_user['github_access_token'],
                'projects': current_user['projects'],
                'full_name': current_user['full_name']
            }
            # Begin user session by logging the user in
            session['user'] = json.loads(json_util.dumps(data))
            return redirect(next_url)

One could suggest instead of rewriting the data variable each time we can use this a a data structure or look at the User Model and see that it returns the json from the .json function. 

So the code would actually look like:

    @github_route.route('/github/callback')
    @github.authorized_handler
    def authorized(oauth_token):
        next_url = request.args.get('next') or url_for('dashboard.dashboard')
        if oauth_token is None:
            flash("Authorization failed.")
            print(failed)
            return redirect(next_url)
    
        g = GitAPI(oauth_token)
        git_user = g.get_user()
        email = git_user.email
        # if the user is found set up a session and redirect index route
        if user.find_one({'email': email}):
            # this is a user who has already registerd
            current_user = user.find_one({'email': email})
            # Begin user session by logging the user in
            session['user'] = json.loads(json_util.dumps(current_user.json()))
            # redirect to index route where the home page will be rendered for user session
            return redirect(next_url)
        else:
            g = GitAPI(oauth_token)
            git_user = g.get_user()
            # create a new User
            new_user = User(email=git_user.email)
            new_user.github_access_token = oauth_token
            new_user.full_name = git_user.name
            new_user.server_ip = request.remote_addr
            new_user.client_ip = request.environ.get(
                'HTTP_X_FORWARDED_FOR')
            # insert new user collection to data base
            user_id = user.insert_one(new_user.json()).inserted_id
            # define current user as the new collection
            current_user = user.find_one({'github_access_token': oauth_token})
            # model for persistent data
            current_user.json()
            # Begin user session by logging the user in
            session['user'] = json.loads(json_util.dumps(current_user.json()))
            return redirect(next_url)
from flask import Flask, jsonify, session, request
from flask_cors import CORS
import psycopg2
import hashlib

app = Flask(__name__)
CORS(app, supports_credentials=True, origins=['http://localhost:3000'])

app.secret_key = "i-am_secret,_sooooooo_so-secret"

# Get Connection to the DB w/ superuser
def get_superuser_conn():
    connection = psycopg2.connect(
        host="localhost",
            database="moviesearch", #mine is lowercase, update to match yours
            user="postgres",
            password="dbisFun@24" #edit to match your password
    )
    return connection

# Function to Keep User Logged In If Never Logged Out
@app.route('/check_session', methods=['GET'])
def check_session(): 
    if 'username' in session:
        print("Session Exists")
        return jsonify({'username': session['username']}), 200
    else:
        print("No Session")
        return jsonify({'username': None}), 200
    
# Function to Log a User Out
@app.route('/logout', methods=['POST'])
def logout():
    session.pop('username', None)
    return jsonify({'message': 'success'}), 200

# Function to Register Users
@app.route('/register', methods=['POST'])
def register_user():
    print("On Register Page")
    conn = get_superuser_conn()
    cur = conn.cursor()
    # Extract form data from the request
    data = request.json
    try:
        print("Trying SELECT Query to Find Identical User")
        cur.execute(
            "SELECT usename FROM pg_user WHERE usename = '" + str(data['username']) + "'")
        existing_user = cur.fetchone()
        print("Fetched User")
        if existing_user:
            print("Username Taken")
            return jsonify({'message': 'username already taken'}), 403
        else:
            print("Username Not Taken")
            cur.execute("CREATE USER \"" + str(data['username']) + "\" WITH PASSWORD '" + str(data['password']) + "'")
            conn.commit()
            print("Executed CREATE USER Query")
            cur.execute("GRANT movie_user TO \"" + str(data['username']) + "\"")
            print("Executed GRANT Permissions Query")
            conn.commit()
            cur.execute("INSERT INTO Movie_User(userID, f_name, l_name, email) \
                        VALUES('" + str(data['username']) + "', '" + str(data['firstName']) + "', '" \
                        + str(data['lastName']) + "', '" + str(data['email']) + "')")
            conn.commit()
            session['username'] = data['username']
            print("Created User")
            return jsonify({'message': 'User created successfully', 'username': data['username']}), 201
    except Exception as e:
        conn.rollback()
        return {'Error': str(e)}, 500
    finally:
        cur.close()
        conn.close()

# Function for Logging In
@app.route('/login', methods=['POST'])
def login_user():
    print("On Login Page")
    conn = get_superuser_conn()
    cur = conn.cursor()
    # Extract form data from the request
    data = request.json
    try:
        # Check if the username exists
        cur.execute("SELECT rolname, rolpassword FROM pg_authid WHERE rolname = '" + str(data['username']) + "'")
        existing_user = cur.fetchone()
        print(data)
        if existing_user:
            print("User Exists, Check Password")
            # Encrypt the Password, Concatenated w/ 'md5'
            hashed_pw = str(data['password']) + str(data['username'])
            hashed_pw = hashlib.md5(hashed_pw.encode())
            hashed_pw = hashed_pw.hexdigest()
            hashed_pw = 'md5' + hashed_pw
            # Check if the password is correct
            if existing_user[1] == hashed_pw:
                session['username'] = data['username']
                return {'message': 'Login successful', 'username': data['username']}, 200
            else:
                return {'message': 'Incorrect password'}, 401  # Unauthorized
        else:
            return {'message': 'User not found'}, 404  # Not Found
    except Exception as e:
        return {'message': 'Internal Server Error', 'error': str(e)}, 500  # Internal Server Error
    finally:
        cur.close()
        conn.close()

if __name__ == "__main__":
    app.run(debug=True, port=8080)
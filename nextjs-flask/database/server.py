from flask import Flask, jsonify, session, request
from flask_cors import CORS
import psycopg2

app = Flask(__name__)
CORS(app, supports_credentials=True, origins=['http://localhost:3000'])

app.secret_key = "i-am_secret,_sooooooo_so-secret"

def get_superuser_conn():
    connection = psycopg2.connect(
        host="localhost",
            database="moviesearch", #mine is lowercase, update to match yours
            user="postgres",
            password="Harley69?!" #edit to match your password
    )
    return connection

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
            session['username'] = data['username']
            print("Created User")
            return jsonify({'message': 'User created successfully', 'username': data['username']}), 201
    except Exception as e:
        conn.rollback()
        return {'Error': str(e)}, 500
    finally:
        cur.close()
        conn.close()


if __name__ == "__main__":
    app.run(debug=True, port=8080)
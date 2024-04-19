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

@app.route('/getactors', methods=['GET'])
def get_actors():
    conn = get_superuser_conn()
    cur = conn.cursor()
    cur.execute("SELECT fname, lname \
                    FROM Actor \
                    INNER JOIN Acts ON Actor.actorID = Acts.actorID")
    names = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify({'first_name': name[0], 'last_name': name[1]} for name in names)

@app.route('/getactorsofmovie', methods=['GET'])
def get_actors_of_movie():
    conn = get_superuser_conn()
    cur = conn.cursor()
    data = request.json
    cur.execute("SELECT fname, lname \
                FROM Actor \
                INNER JOIN Acts ON Actor.actorID = Acts.actorID \
                INNER JOIN Movie ON Acts.movieID = Movie.movieID \
                WHERE Movie.title = %s", (data['movie_title'],))
    names = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify({'first_name': name[0], 'last_name': name[1]} for name in names)

@app.route('/getmovies', methods=['GET'])
def get_movies():
    conn = get_superuser_conn()
    cur = conn.cursor()
    cur.execute("SELECT title FROM Movie")
    movies = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify({'movie_title': movie[0]} for movie in movies)

@app.route('/getmoviegenre', methods=['GET'])
def get_movie_genre():
    conn = get_superuser_conn()
    cur = conn.cursor()
    data = request.json
    cur.execute("SELECT title FROM Movie WHERE genre = %s", (data['genre_type'],))
    movies = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify({'movie_title': movie[0]} for movie in movies)

@app.route('/getmoviesofactor', method=['GET'])
def get_movies_of_actor():
    conn = get_superuser_conn()
    cur = conn.cursor()
    data = request.json
    cur.execute("SELECT title \
                FROM Movie \
                INNER JOIN Acts ON Movie.movieID = Acts.movieID \
                INNER JOIN Actor ON Acts.actorID = Actor.actorID \
                WHERE Actor.actorID = %s", (data['actor']))
    movies = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify({'movie_title': movie[0]} for movie in movies)

# NOTE: Functions Below Haven't Been Tested
@app.route('/getreviews', methods=['GET'])
def get_reviews():
    conn = get_superuser_conn()
    cur = conn.cursor()
    data = request.json
    cur.execute("SELECT username, rating, review_content \
                FROM Review \
                INNER JOIN Movie ON Review.movieID = Movie.movieID \
                WHERE Movie.title = %s", data['movie_title'])
    reviews = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify({'user_name': review[0], 'rating': review[1], 'content': review[2]} for review in reviews)

@app.route('/getrating', methods=['GET'])
def get_ratings():
    conn = get_superuser_conn()
    cur = conn.cursor()
    data = request.json
    cur.execute("SELECT AVG(rating) \
                FROM Review \
                INNER JOIN Movie ON Review.movieID = Movie.movieID \
                WHERE movieID = %s GROUP BY Movie.title", (data['title']),)
    rating = cur.fetchone()
    cur.close()
    conn.close()
    return jsonify(rating)

if __name__ == "__main__":
    app.run(debug=True, port=8080)
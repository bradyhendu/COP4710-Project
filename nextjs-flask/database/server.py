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
    cur.execute("SELECT DISTINCT fname, lname, Actor.actorID \
                    FROM Actor \
                    INNER JOIN Acts ON Actor.actorID = Acts.actorID")
    actors = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([{"actor_name": actor[0] + " " + actor[1], "actor_id": actor[2]} for actor in actors])

@app.route('/getactorsofmovie', methods=['POST'])
def get_actors_of_movie():
    conn = get_superuser_conn()
    cur = conn.cursor()
    data = request.json
    print(data)
    cur.execute("SELECT fname, lname, Actor.actorID\
                FROM Actor \
                INNER JOIN Acts ON Actor.actorID = Acts.actorID \
                INNER JOIN Movie ON Acts.movieID = Movie.movieID \
                WHERE Movie.movieID = %s", (data['movie_id'],))
    actors = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([{"actor_name": actor[0] + " " + actor[1], "actor_id": actor[2]} for actor in actors])

@app.route('/getmoviesofactor', methods=['POST'])
def get_movies_of_actor():
    print("Getting Movies the Actor Has Starred In")
    conn = get_superuser_conn()
    cur = conn.cursor()
    data = request.json
    print(data)
    cur.execute("SELECT title, Movie.movieID \
                FROM Movie \
                INNER JOIN Acts ON Movie.movieID = Acts.movieID \
                INNER JOIN Actor ON Acts.actorID = Actor.actorID \
                WHERE Actor.actorID = %s", (data['actor_id'],))
    movies = cur.fetchall()
    print("movies: ", movies)
    cur.close()
    conn.close()
    return jsonify([{'movie_title': movie[0], 'movie_id': movie[1]} for movie in movies])

@app.route('/actors/<string:actor_id>', methods=['GET'])
def get_actor_details(actor_id):
    conn = get_superuser_conn()
    cur = conn.cursor()
    cur.execute("SELECT fname, lname, dob, since \
                FROM Actor \
                WHERE actorID = %s", (actor_id,))
    actor = cur.fetchone()
    cur.close()
    conn.close()
    #convert time to string
    if actor is None:
        # No actor found, return an appropriate response
        return jsonify({"error": "No Actor Found With the Provided ID"}), 404

    actor = list(actor)
    
    return jsonify({'name': actor[0] + " " + actor[1], 'date_of_birth': actor[2], 'since': actor[3]})

@app.route('/movies/<string:movie_id>', methods=['GET'])
def get_movie_details(movie_id):
    print(movie_id)
    conn = get_superuser_conn()
    cur = conn.cursor()
    cur.execute("SELECT title, release_date, duration \
                FROM Movie WHERE movieID = %s", (movie_id,))
    movie = cur.fetchone()
    cur.close()
    conn.close()
    #convert time to string
    if movie is None:
        # No movie found, return an appropriate response
        return jsonify({"error": "No movie found with the provided ID"}), 404

    # Convert time to string
    movie = list(movie)
    movie[2] = str(movie[2])
    
    return jsonify({'title': movie[0], 'release_date': movie[1], 'duration': movie[2]})

@app.route('/getmovies', methods=['GET'])
def get_movies():
    conn = get_superuser_conn()
    cur = conn.cursor()
    cur.execute("SELECT title, Movie.movieID, string_agg(genre, ', ') \
                FROM Movie \
                INNER JOIN Movie_Genre ON Movie.movieID = Movie_Genre.movieID \
                GROUP BY Movie.title, Movie.movieID")
    movies = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([{'movie_title': movie[0], 'movie_id': movie[1], 'genres': movie[2]} for movie in movies])

@app.route('/getmoviegenre', methods=['POST'])
def get_movie_genre():
    print("Getting Movies Based On Genre")
    conn = get_superuser_conn()
    cur = conn.cursor()
    data = request.json
    print(data)
    cur.execute("SELECT title, movieID FROM Movie WHERE genre = %s", (data['genre_type'],))
    movies = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([{'movie_title': movie[0], 'movie_id': movie[1]} for movie in movies])

# NOTE: Function Below Haven't Been Tested
@app.route('/getreviews', methods=['GET'])
def get_reviews():
    conn = get_superuser_conn()
    cur = conn.cursor()
    data = request.json
    cur.execute("SELECT username, rating, review_content \
                FROM Review \
                INNER JOIN Movie ON Review.movieID = Movie.movieID \
                WHERE Movie.title = %s", (data['movie_title'],))
    reviews = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([{'user_name': review[0], 'rating': review[1], 'content': review[2]} for review in reviews])

@app.route('/getrating', methods=['GET'])
def get_rating():
    conn = get_superuser_conn()
    cur = conn.cursor()
    data = request.json
    cur.execute("SELECT AVG(rating)::REAL \
                FROM Review \
                INNER JOIN Movie ON Review.movieID = Movie.movieID \
                WHERE Movie.title = %s \
                GROUP BY Movie.title", (data['title'],))
    rating = cur.fetchone()
    cur.close()
    conn.close()
    return jsonify(rating)

@app.route('/recommendations', methods=['GET'])
def recommendation_list():
    conn = get_superuser_conn()
    cur = conn.cursor()
    # I Could Be Wrong About Using session['username']
    cur.execute("SELECT genre, COUNT(genre) \
                FROM Movie_Genre \
                INNER JOIN Review ON Movie_Genre.movieID = Review.movieID \
                INNER JOIN Movie ON Movie_Genre.movieID = Movie.movieID \
                WHERE username = %s AND rating >= 4.0 \
                GROUP BY genre \
                ORDER BY COUNT(genre) DESC LIMIT 3", (session['username'],))
    genres = cur.fetchall()
    if genres is not None:
        cur.execute("SELECT title \
                    FROM Movie \
                    INNER JOIN Movie_Genre ON Movie.movieID = Movie_Genre.movieID \
                    WHERE genre = %s OR genre = %s OR genre = %s \
                    ORDER BY random() \
                    LIMIT 10", (genres[0], genres[1], genres[2]))
        movies = cur.fetchall()
        cur.close()
        conn.close()
        return jsonify({'title': movie[0]} for movie in movies)
    else:
        cur.close()
        conn.close()
        return jsonify({'message': 'No Recommendations At the Moment'})
    
@app.route('/addreview', methods=['POST'])
def add_review():
    conn = get_superuser_conn()
    cur = conn.cursor()
    data = request.json
    try:
        cur.execute("SELECT movieID FROM Movie WHERE movieID = %S", (data['movie_ID'],))
        movie = cur.fetchone()
        cur.execute("INSERT INTO Review(rating, review_content, username, movieID) VALUES \
                    (%s, %s, %s, %s)", (data['rate'], data['content'], data['user_name'], movie,))
        return jsonify({'message': 'Review Added Successfully'})
    except Exception as e:
        return {'message': 'Internal Server Error', 'error': str(e)}, 500  # Internal Server Error
    finally:
        cur.close()
        conn.close()

if __name__ == "__main__":
    app.run(debug=True, port=8080)
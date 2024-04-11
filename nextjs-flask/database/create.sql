DROP TABLE IF EXISTS Movie_User CASCADE;
CREATE TABLE Movie_User(
    userID VARCHAR(255) PRIMARY KEY,
    f_name VARCHAR(255),
    l_name VARCHAR(255),
    email VARCHAR(255)
);

DROP TABLE IF EXISTS Actor CASCADE;
CREATE TABLE Actor(
    actorID VARCHAR(255) PRIMARY KEY,
    fname VARCHAR(255),
    lname VARCHAR(255),
    DoB DATE,
    since INT
);

DROP TABLE IF EXISTS Movie CASCADE;
CREATE TABLE Movie(
    movieID VARCHAR(255) PRIMARY KEY,
    title VARCHAR(255),
    genre VARCHAR(255),
    release_date DATE,
    duration TIME,
    directorID VARCHAR(255),
    FOREIGN KEY (directorID) REFERENCES Actor(actorID)
);

DROP TABLE IF EXISTS Review CASCADE;
CREATE TABLE Review(
    reviewID VARCHAR(255) PRIMARY KEY,
    rating DECIMAL(2, 1),
    review_content TEXT,
    username VARCHAR(255),
    movieID VARCHAR(255),
    FOREIGN KEY (movieID) REFERENCES Movie(movieID)
);

DROP TABLE IF EXISTS Likes CASCADE;
CREATE TABLE Likes
(
    username VARCHAR(255) PRIMARY KEY,
    movieID VARCHAR(255),
    FOREIGN KEY (movieID) REFERENCES Movie(movieID)
);

DROP TABLE IF EXISTS Acts CASCADE;
CREATE TABLE Acts
(
    movieID VARCHAR(20),
    actorID VARCHAR(20),
    FOREIGN KEY (movieID) REFERENCES Movie(movieID),
    FOREIGN KEY (actorID) REFERENCES Actor(actorID)
);

DROP TABLE IF EXISTS Movie_Genre CASCADE;
CREATE TABLE Movie_Genre(
    movieID VARCHAR(255),
    genre VARCHAR(255),
    FOREIGN KEY (movieID) REFERENCES Movie(movieID)
);
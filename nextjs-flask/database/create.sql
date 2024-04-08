DROP TABLE IF EXISTS Actor CASCADE;
CREATE TABLE Actor(
    actorID VARCHAR(255),
    fname VARCHAR(255),
    lname VARCHAR(255),
    DoB DATE,
    since INT,
    PRIMARY KEY (actorID)
);

DROP TABLE IF EXISTS Movie CASCADE;
CREATE TABLE Movie(
    movieID VARCHAR(255),
    title VARCHAR(255),
    release_date DATE,
    duration TIME,
    directorID VARCHAR(255),
    PRIMARY KEY (movieID, directorID),
    FOREIGN KEY (directorID) REFERENCES Actor(actorID)
);

DROP TABLE IF EXISTS Review CASCADE;
CREATE TABLE Review(
    reviewID VARCHAR(255),
    rating REAL,
    review_content TEXT,
    username VARCHAR(255),
    mID VARCHAR(255),
    PRIMARY KEY (reviewID, movieID),
    FOREIGN KEY (mID) REFERENCES Movie(movieID)
);

DROP TABLE IF EXISTS Likes CASCADE;
CREATE TABLE Likes
(
    username VARCHAR(255),
    mID VARCHAR(255),
    PRIMARY KEY (username, movieID),
    FOREIGN KEY (mID) REFERENCES Movie(movieID)
);

DROP TABLE IF EXISTS Acts CASCADE;
CREATE TABLE Acts
(
    mID VARCHAR(20),
    actorID VARCHAR(20),
    PRIMARY KEY (mID, actorID),
    FOREIGN KEY (mID) REFERENCES Movie(movieID),
    FOREIGN KEY (actorID) REFERENCES Actor(actorID)
);
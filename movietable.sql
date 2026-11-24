-- SQL script for creating a movie table
CREATE TABLE movie (
    movie_id INT PRIMARY KEY,
    movie_title VARCHAR(50),
    movie_director VARCHAR(50),
    movie_min INT,
    release_date DATE,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Creating Sequence for auto-incrementing ID
CREATE SEQUENCE movie_seq
    START WITH 101
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- MOVIE Indexes
CREATE INDEX idx_movie_title   ON movie (movie_title);
CREATE INDEX idx_movie_genre   ON movie (genre);
CREATE INDEX idx_movie_mood_id ON movie (mood_id);
CREATE INDEX idx_movie_user_id ON movie (user_id);
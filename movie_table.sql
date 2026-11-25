-- SQL script for creating a movie table
CREATE TABLE movie (
    movie_id INT PRIMARY KEY,
    movie_title VARCHAR2(100) NOT NULL,
    movie_director VARCHAR(50),
    movie_min INT,
    release_date DATE,
    genre VARCHAR2(50),
    user_id INT NOT NULL,
    mood_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (mood_id) REFERENCES mood(mood_id)
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
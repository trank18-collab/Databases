-- SQL script for creating a music table
CREATE TABLE Music (
    song_id INT PRIMARY KEY,
    song_title VARCHAR2(100) NOT NULL,
    artist_name VARCHAR2(100),
    song_min INT,
    release_date DATE,
    genre VARCHAR2(50) NOT NULL,
    user_id INT NOT NULL,
    mood_id INT NOT NULL,
    movie_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (mood_id) REFERENCES mood(mood_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

-- Creating Sequence for auto-incrementing ID
CREATE SEQUENCE music_seq
    START WITH 1001
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- MUSIC Indexes
CREATE INDEX idx_music_title    ON music (song_title);
CREATE INDEX idx_music_artist   ON music (artist_name);
CREATE INDEX idx_music_genre    ON music (genre);
CREATE INDEX idx_music_mood_id  ON music (mood_id);
CREATE INDEX idx_music_movie_id ON music (movie_id);
CREATE INDEX idx_music_user_id  ON music (user_id);

-- SQL script for inserting sample data into the music table
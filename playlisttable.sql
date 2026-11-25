CREATE TABLE PLAYLIST (
    playlist_id NUMBER PRIMARY KEY,
    playlist_name VARCHAR2(100) NOT NULL,
    movie_id NUMBER NOT NULL,
    music_genre_id NUMBER NOT NULL,
    created_date DATE DEFAULT SYSDATE NOT NULL,

    FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id),
    FOREIGN KEY (music_genre_id)
        REFERENCES MUSIC_GENRE(music_genre_id)
);

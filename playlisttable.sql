CREATE TABLE PLAYLIST (
    playlist_id NUMBER PRIMARY KEY,
    playlist_name VARCHAR2(100) NOT NULL,
    movie_id NUMBER NOT NULL,
    music_genre VARCHAR2(50) NOT NULL,
    created_date DATE DEFAULT SYSDATE NOT NULL,

    FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id)
);

CREATE SEQUENCE playlist_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

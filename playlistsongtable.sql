CREATE TABLE PLAYLIST_SONG (
    playlist_id NUMBER NOT NULL,
    song_id NUMBER NOT NULL,

    PRIMARY KEY (playlist_id, song_id),

    FOREIGN KEY (playlist_id)
        REFERENCES PLAYLIST(playlist_id),

    FOREIGN KEY (song_id)
        REFERENCES MUSIC(song_id)
);

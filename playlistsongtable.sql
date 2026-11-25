CREATE TABLE PLAYLIST_SONG (
    playlist_id NUMBER NOT NULL,
    song_id NUMBER NOT NULL,
    track_number NUMBER NOT NULL,

    PRIMARY KEY (playlist_id, song_id),
    UNIQUE (playlist_id, track_number),

    FOREIGN KEY (playlist_id)
        REFERENCES PLAYLIST(playlist_id),

    FOREIGN KEY (song_id)
        REFERENCES MUSIC(song_id)
);

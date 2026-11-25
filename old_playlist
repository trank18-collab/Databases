CREATE SEQUENCE playlist_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE TABLE playlist (
    playlist_id INT PRIMARY KEY,
    playlist_name VARCHAR2(100) NOT NULL,
    movie_id INT NOT NULL,
    music_genre VARCHAR2(50) NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

CREATE TABLE playlist_song (
    playlist_id INT NOT NULL,
    song_id INT NOT NULL,
    track_number NUMBER NOT NULL,
    PRIMARY KEY (playlist_id, song_id),
    UNIQUE (playlist_id, track_number),
    FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
    FOREIGN KEY (song_id) REFERENCES music(song_id)
);

CREATE OR REPLACE PROCEDURE generate_playlist (
    p_movie_id IN NUMBER,
    p_music_genre IN VARCHAR2,
    p_playlist_name IN VARCHAR2,
    p_playlist_id OUT NUMBER
)
AS
    v_movie_count PLS_INTEGER;
    v_song_count PLS_INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO v_movie_count
    FROM movie
    WHERE movie_id = p_movie_id;

    IF v_movie_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Movie does not exist.');
    END IF;

    SELECT COUNT(*)
    INTO v_song_count
    FROM music
    WHERE movie_id = p_movie_id
      AND genre = p_music_genre;

    IF v_song_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'No songs match the selected movie and music genre.'
        );
    END IF;

    p_playlist_id := playlist_seq.NEXTVAL;

    INSERT INTO playlist (
        playlist_id,
        playlist_name,
        movie_id,
        music_genre
    )
    VALUES (
        p_playlist_id,
        p_playlist_name,
        p_movie_id,
        p_music_genre
    );

    INSERT INTO playlist_song (
        playlist_id,
        song_id,
        track_number
    )
    SELECT
        p_playlist_id,
        m.song_id,
        ROW_NUMBER() OVER (ORDER BY m.song_title, m.song_id)
    FROM music m
    WHERE m.movie_id = p_movie_id
      AND m.genre = p_music_genre;

    DBMS_OUTPUT.PUT_LINE('Playlist successfully generated!');
    DBMS_OUTPUT.PUT_LINE('Playlist ID: ' || p_playlist_id);
    DBMS_OUTPUT.PUT_LINE('Number of songs: ' || v_song_count);
END;
/

CREATE OR REPLACE PROCEDURE display_playlist (
    p_playlist_id IN NUMBER
)
AS
    v_playlist_name playlist.playlist_name%TYPE;
    v_movie_name movie.movie_title%TYPE;
    v_music_genre playlist.music_genre%TYPE;
BEGIN
    SELECT
        p.playlist_name,
        m.movie_title,
        p.music_genre
    INTO
        v_playlist_name,
        v_movie_name,
        v_music_genre
    FROM playlist p
    JOIN movie m ON m.movie_id = p.movie_id
    WHERE p.playlist_id = p_playlist_id;

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('          YOUR PLAYLIST');
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('Playlist: ' || v_playlist_name);
    DBMS_OUTPUT.PUT_LINE('Movie: ' || v_movie_name);
    DBMS_OUTPUT.PUT_LINE('Music Genre: ' || v_music_genre);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');

    FOR song_record IN (
        SELECT
            ps.track_number,
            m.song_title,
            m.artist_name,
            mo.mood_name
        FROM playlist_song ps
        JOIN music m ON m.song_id = ps.song_id
        LEFT JOIN mood mo ON mo.mood_id = m.mood_id
        WHERE ps.playlist_id = p_playlist_id
        ORDER BY ps.track_number
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            song_record.track_number || '. ' ||
            song_record.song_title || ' - ' ||
            song_record.artist_name ||
            CASE
                WHEN song_record.mood_name IS NOT NULL
                THEN ' (' || song_record.mood_name || ')'
            END
        );
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('======================================');
END;
/

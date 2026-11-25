CREATE SEQUENCE PLAYLIST_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE OR REPLACE PROCEDURE GENERATE_PLAYLIST (
    P_MOVIE_ID IN NUMBER,
    P_MUSIC_GENRE_ID IN NUMBER,
    P_PLAYLIST_NAME IN VARCHAR2,
    P_PLAYLIST_ID OUT NUMBER
)
AS
    V_SONG_COUNT NUMBER;
    V_MOVIE_COUNT NUMBER;
    V_GENRE_COUNT NUMBER;

BEGIN

    -- Check that the movie exists
    SELECT COUNT(*)
    INTO V_MOVIE_COUNT
    FROM MOVIE
    WHERE MOVIE_ID = P_MOVIE_ID;

    IF V_MOVIE_COUNT = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Movie does not exist.'
        );
    END IF;


    -- Check that the music genre exists
    SELECT COUNT(*)
    INTO V_GENRE_COUNT
    FROM MUSIC_GENRE
    WHERE MUSIC_GENRE_ID = P_MUSIC_GENRE_ID;

    IF V_GENRE_COUNT = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Music genre does not exist.'
        );
    END IF;


    -- Generate a unique playlist ID
    P_PLAYLIST_ID := PLAYLIST_SEQ.NEXTVAL;


    -- Create the playlist
    INSERT INTO PLAYLIST (
        PLAYLIST_ID,
        PLAYLIST_NAME,
        MOVIE_ID,
        MUSIC_GENRE_ID
    )
    VALUES (
        P_PLAYLIST_ID,
        P_PLAYLIST_NAME,
        P_MOVIE_ID,
        P_MUSIC_GENRE_ID
    );


    -- Find matching songs and add them to the playlist
    INSERT INTO PLAYLIST_SONG (
        PLAYLIST_ID,
        SONG_ID,
        TRACK_NUMBER
    )
    SELECT
        P_PLAYLIST_ID,
        S.SONG_ID,
        ROW_NUMBER() OVER (ORDER BY S.TITLE)

    FROM SONG S

    JOIN MOOD MO
        ON S.MOOD_ID = MO.MOOD_ID

    JOIN MOVIE_GENRE MG
        ON MO.MOOD_ID = MG.MOOD_ID

    JOIN MOVIE_MOVIE_GENRE MMG
        ON MG.MOVIE_GENRE_ID = MMG.MOVIE_GENRE_ID

    WHERE MMG.MOVIE_ID = P_MOVIE_ID

    AND S.MUSIC_GENRE_ID = P_MUSIC_GENRE_ID;


    -- Get the number of songs inserted
    V_SONG_COUNT := SQL%ROWCOUNT;


    -- Check whether any songs matched
    IF V_SONG_COUNT = 0 THEN

        DELETE FROM PLAYLIST
        WHERE PLAYLIST_ID = P_PLAYLIST_ID;

        RAISE_APPLICATION_ERROR(
            -20003,
            'No songs match the selected movie and music genre.'
        );

    END IF;


    -- Display success message
    DBMS_OUTPUT.PUT_LINE('Playlist successfully generated!');
    DBMS_OUTPUT.PUT_LINE('Playlist ID: ' || P_PLAYLIST_ID);
    DBMS_OUTPUT.PUT_LINE('Number of songs: ' || V_SONG_COUNT);

END;
/

CREATE OR REPLACE PROCEDURE DISPLAY_PLAYLIST (
    P_PLAYLIST_ID IN NUMBER
)
AS

    V_PLAYLIST_NAME VARCHAR2(100);
    V_MOVIE_NAME VARCHAR2(100);
    V_GENRE_NAME VARCHAR2(50);

BEGIN

    -- Retrieve playlist information
    SELECT
        P.PLAYLIST_NAME,
        M.TITLE,
        MG.GENRE_NAME

    INTO
        V_PLAYLIST_NAME,
        V_MOVIE_NAME,
        V_GENRE_NAME

    FROM PLAYLIST P

    JOIN MOVIE M
        ON P.MOVIE_ID = M.MOVIE_ID

    JOIN MUSIC_GENRE MG
        ON P.MUSIC_GENRE_ID = MG.MUSIC_GENRE_ID

    WHERE P.PLAYLIST_ID = P_PLAYLIST_ID;


    -- Display playlist information
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('          YOUR PLAYLIST');
    DBMS_OUTPUT.PUT_LINE('======================================');

    DBMS_OUTPUT.PUT_LINE('Playlist: ' || V_PLAYLIST_NAME);
    DBMS_OUTPUT.PUT_LINE('Movie: ' || V_MOVIE_NAME);
    DBMS_OUTPUT.PUT_LINE('Music Genre: ' || V_GENRE_NAME);

    DBMS_OUTPUT.PUT_LINE('--------------------------------------');


    -- Display all songs
    FOR SONG_RECORD IN (
        SELECT
            PS.TRACK_NUMBER,
            S.TITLE,
            S.ARTIST,
            MO.MOOD_NAME

        FROM PLAYLIST_SONG PS

        JOIN SONG S
            ON PS.SONG_ID = S.SONG_ID

        JOIN MOOD MO
            ON S.MOOD_ID = MO.MOOD_ID

        WHERE PS.PLAYLIST_ID = P_PLAYLIST_ID

        ORDER BY PS.TRACK_NUMBER
    )

    LOOP

        DBMS_OUTPUT.PUT_LINE(
            SONG_RECORD.TRACK_NUMBER || '. ' ||
            SONG_RECORD.TITLE ||
            ' - ' ||
            SONG_RECORD.ARTIST ||
            ' (' || SONG_RECORD.MOOD_NAME || ')'
        );

    END LOOP;


    DBMS_OUTPUT.PUT_LINE('======================================');

END;
/

-- ============================================================
-- OPTIONAL PREREQUISITE: Parent rows in USERS and MOOD
-- (Skip if your teammates already inserted these IDs)
-- ============================================================
INSERT INTO users (user_id, genre) VALUES (1, 'Sci-Fi');
INSERT INTO users (user_id, genre) VALUES (2, 'Drama');
INSERT INTO users (user_id, genre) VALUES (3, 'Action');

INSERT INTO mood (mood_id, mood_name, mood_percent) VALUES (1, 'Atmospheric', 88.50);
INSERT INTO mood (mood_id, mood_name, mood_percent) VALUES (2, 'Melancholic', 91.00);
INSERT INTO mood (mood_id, mood_name, mood_percent) VALUES (3, 'Energetic',   94.25);
INSERT INTO mood (mood_id, mood_name, mood_percent) VALUES (4, 'Nostalgic',   85.00);
INSERT INTO mood (mood_id, mood_name, mood_percent) VALUES (5, 'Suspenseful', 89.75);


-- ============================================================
-- 3A. INSERT SAMPLE DATA INTO MOVIE (Using MOVIE_SEQ & Synonym)
-- ============================================================
INSERT INTO awe_movies (movie_id, movie_title, movie_director, movie_min, release_date, genre, user_id, mood_id)
VALUES (movie_seq.NEXTVAL, 'Interstellar', 'Christopher Nolan', 169, DATE '2014-11-07', 'Sci-Fi', 1, 1);

INSERT INTO awe_movies (movie_id, movie_title, movie_director, movie_min, release_date, genre, user_id, mood_id)
VALUES (movie_seq.NEXTVAL, 'La La Land', 'Damien Chazelle', 128, DATE '2016-12-09', 'Romance', 2, 4);

INSERT INTO awe_movies (movie_id, movie_title, movie_director, movie_min, release_date, genre, user_id, mood_id)
VALUES (movie_seq.NEXTVAL, 'Spider-Man: Into the Spider-Verse', 'Bob Persichetti', 117, DATE '2018-12-14', 'Action', 3, 3);

INSERT INTO awe_movies (movie_id, movie_title, movie_director, movie_min, release_date, genre, user_id, mood_id)
VALUES (movie_seq.NEXTVAL, 'Dune: Part Two', 'Denis Villeneuve', 166, DATE '2024-03-01', 'Sci-Fi', 1, 5);

INSERT INTO awe_movies (movie_id, movie_title, movie_director, movie_min, release_date, genre, user_id, mood_id)
VALUES (movie_seq.NEXTVAL, 'Past Lives', 'Celine Song', 106, DATE '2023-06-02', 'Drama', 2, 2);


-- ============================================================
-- 3B. INSERT SAMPLE DATA INTO MUSIC (Using MUSIC_SEQ & Synonym)
-- ============================================================
INSERT INTO awe_music (song_id, song_title, artist_name, song_min, release_date, genre, user_id, mood_id, movie_id)
VALUES (music_seq.NEXTVAL, 'Cornfield Chase', 'Hans Zimmer', 2, DATE '2014-11-18', 'Soundtrack', 1, 1, 101);

INSERT INTO awe_music (song_id, song_title, artist_name, song_min, release_date, genre, user_id, mood_id, movie_id)
VALUES (music_seq.NEXTVAL, 'Space Song', 'Beach House', 5, DATE '2015-08-28', 'Dream Pop', 1, 1, 101);

INSERT INTO awe_music (song_id, song_title, artist_name, song_min, release_date, genre, user_id, mood_id, movie_id)
VALUES (music_seq.NEXTVAL, 'City of Stars', 'Ryan Gosling & Emma Stone', 2, DATE '2016-12-09', 'Jazz', 2, 4, 102);

INSERT INTO awe_music (song_id, song_title, artist_name, song_min, release_date, genre, user_id, mood_id, movie_id)
VALUES (music_seq.NEXTVAL, 'Sunflower', 'Post Malone & Swae Lee', 3, DATE '2018-10-18', 'Hip-Hop', 3, 3, 103);

INSERT INTO awe_music (song_id, song_title, artist_name, song_min, release_date, genre, user_id, mood_id, movie_id)
VALUES (music_seq.NEXTVAL, 'What''s Up Danger', 'Blackway & Black Caviar', 4, DATE '2018-12-14', 'Hip-Hop', 3, 3, 103);

INSERT INTO awe_music (song_id, song_title, artist_name, song_min, release_date, genre, user_id, mood_id, movie_id)
VALUES (music_seq.NEXTVAL, 'A Time of Quiet Between the Storms', 'Hans Zimmer', 4, DATE '2024-02-23', 'Soundtrack', 1, 5, 104);

INSERT INTO awe_music (song_id, song_title, artist_name, song_min, release_date, genre, user_id, mood_id, movie_id)
VALUES (music_seq.NEXTVAL, 'Quiet Eyes', 'Sharon Van Etten', 4, DATE '2023-06-02', 'Indie', 2, 2, 105);

COMMIT;
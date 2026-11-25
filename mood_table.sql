-- SQL script for creating a mood table
CREATE TABLE mood (
    mood_id INT PRIMARY KEY,
    mood_name VARCHAR2(50),
    mood_percent NUMBER(5, 2)
);

-- SQL for creating the mood sequence
CREATE SEQUENCE mood_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- MOOD Indexes
CREATE INDEX idx_mood_percent ON mood (mood_percent);
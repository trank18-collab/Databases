-- SQL for creating the mood sequence
CREATE SEQUENCE mood_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- MOOD Indexes
CREATE INDEX idx_mood_percent ON mood (mood_percent);

-- Mood Synonym
CREATE SYNONYM mood FOR awe_mood;
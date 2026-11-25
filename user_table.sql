-- SQL script for creating the users table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    genre VARCHAR2(50)
);

-- Creating Sequence for auto-incrementing ID
Create SEQUENCE user_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- USERS Indexes
CREATE INDEX idx_user_genre ON users (genre);

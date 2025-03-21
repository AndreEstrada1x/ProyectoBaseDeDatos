CREATE TABLE USER_ROLE (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE "USER" (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role_id INT NOT NULL REFERENCES USER_ROLE(role_id)
);

CREATE TABLE LESSON (
    lesson_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    difficulty_level VARCHAR(50) NOT NULL CHECK (difficulty_level IN ('simple', 'advanced')),
    points_awarded INT NOT NULL DEFAULT 0
);

CREATE TABLE LESSON_CATEGORY (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE LESSON_CATEGORY_REL (
    lesson_id INT NOT NULL REFERENCES LESSON(lesson_id),
    category_id INT NOT NULL REFERENCES LESSON_CATEGORY(category_id),
    PRIMARY KEY (lesson_id, category_id)
);

CREATE TABLE EXAM (
    exam_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    difficulty_level VARCHAR(50) NOT NULL CHECK (difficulty_level IN ('simple', 'advanced')),
    points_awarded INT NOT NULL DEFAULT 0
);

CREATE TABLE PROGRESS (
    progress_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "USER"(user_id),
    lesson_id INT NOT NULL REFERENCES LESSON(lesson_id),
    status VARCHAR(50) NOT NULL,
    completion_date TIMESTAMP
);

CREATE TABLE EXAM_PROGRESS (
    exam_progress_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "USER"(user_id),
    exam_id INT NOT NULL REFERENCES EXAM(exam_id),
    status VARCHAR(50) NOT NULL,
    completion_date TIMESTAMP
);

CREATE TABLE EXAM_RESULT (
    exam_result_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "USER"(user_id),
    exam_id INT NOT NULL REFERENCES EXAM(exam_id),
    score INT NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE LESSON_RESULT (
    lesson_result_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "USER"(user_id),
    lesson_id INT NOT NULL REFERENCES LESSON(lesson_id),
    score INT NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE USER_SCORE (
    score_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "USER"(user_id),
    total_points INT DEFAULT 0
);

CREATE TABLE REWARD (
    reward_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    cost_points INT NOT NULL
);

CREATE TABLE REWARD_REDEMPTION (
    redemption_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "USER"(user_id),
    reward_id INT NOT NULL REFERENCES REWARD(reward_id),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE LEADERBOARD (
    leaderboard_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "USER"(user_id),
    position INT NOT NULL,
    total_points INT NOT NULL
);

CREATE TABLE QUESTION (
    question_id SERIAL PRIMARY KEY,
    question_text TEXT,
    question_type VARCHAR(50)
);

CREATE TABLE EXAM_QUESTION (
    exam_id INT NOT NULL REFERENCES EXAM(exam_id),
    question_id INT NOT NULL REFERENCES QUESTION(question_id),
    PRIMARY KEY (exam_id, question_id)
);

CREATE TABLE ANSWER_OPTION (
    option_id SERIAL PRIMARY KEY,
    question_id INT NOT NULL REFERENCES QUESTION(question_id),
    option_text TEXT,
    is_correct BOOLEAN
);

CREATE TABLE NOTIFICATION_HISTORY (
    notification_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "USER"(user_id),
    message TEXT,
    sent_date TIMESTAMP
);

CREATE TABLE LOG (
    log_id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "user" VARCHAR(100) NOT NULL,
    affected_table VARCHAR(100) NOT NULL,
    operation VARCHAR(50) NOT NULL,
    details TEXT
);

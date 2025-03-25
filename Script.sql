-- Crear tipo ENUM para question_type
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'question_type_enum') THEN
        CREATE TYPE question_type_enum AS ENUM ('multiple_choice', 'true_false', 'short_answer');
    END IF;
END$$;

-- Tabla de roles de usuario
CREATE TABLE USER_ROLE (
  role_id INT PRIMARY KEY,
  role_name VARCHAR(50) NOT NULL UNIQUE,
  description TEXT
);

-- Tabla de usuarios
CREATE TABLE "USER" (
  user_id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  password CHAR(60) NOT NULL,
  role_id INT NOT NULL,
  FOREIGN KEY (role_id) REFERENCES USER_ROLE(role_id)
);

-- Tabla de lecciones
CREATE TABLE LESSON (
  lesson_id INT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  difficulty_level VARCHAR(50) NOT NULL CHECK (difficulty_level IN ('simple', 'advanced')),
  points_awarded INT NOT NULL DEFAULT 0
);

-- Tabla de categorías
CREATE TABLE LESSON_CATEGORY (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Relación lección-categoría
CREATE TABLE LESSON_CATEGORY_REL (
  lesson_id INT NOT NULL,
  category_id INT NOT NULL,
  PRIMARY KEY (lesson_id, category_id),
  FOREIGN KEY (lesson_id) REFERENCES LESSON(lesson_id),
  FOREIGN KEY (category_id) REFERENCES LESSON_CATEGORY(category_id)
);

-- Tabla de exámenes
CREATE TABLE EXAM (
  exam_id INT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  difficulty_level VARCHAR(50) NOT NULL CHECK (difficulty_level IN ('simple', 'advanced')),
  points_awarded INT NOT NULL DEFAULT 0
);

-- Progreso de lecciones
CREATE TABLE PROGRESS (
  progress_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  lesson_id INT NOT NULL,
  status VARCHAR(50) NOT NULL,
  completion_date TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES "USER"(user_id),
  FOREIGN KEY (lesson_id) REFERENCES LESSON(lesson_id)
);

-- Progreso de exámenes
CREATE TABLE EXAM_PROGRESS (
  exam_progress_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  exam_id INT NOT NULL,
  status VARCHAR(50) NOT NULL,
  completion_date TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES "USER"(user_id),
  FOREIGN KEY (exam_id) REFERENCES EXAM(exam_id)
);

-- Resultados de exámenes
CREATE TABLE EXAM_RESULT (
  exam_result_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  exam_id INT NOT NULL,
  score INT NOT NULL,
  date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES "USER"(user_id),
  FOREIGN KEY (exam_id) REFERENCES EXAM(exam_id)
);

-- Resultados de lecciones
CREATE TABLE LESSON_RESULT (
  lesson_result_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  lesson_id INT NOT NULL,
  score INT NOT NULL,
  date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES "USER"(user_id),
  FOREIGN KEY (lesson_id) REFERENCES LESSON(lesson_id)
);

-- Puntaje acumulado por usuario
CREATE TABLE USER_SCORE (
  score_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  total_points INT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES "USER"(user_id)
);

-- Recompensas
CREATE TABLE REWARD (
  reward_id INT PRIMARY KEY,
  name VARCHAR(100),
  description TEXT,
  cost_points INT NOT NULL
);

-- Canje de recompensas
CREATE TABLE REWARD_REDEMPTION (
  redemption_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  reward_id INT NOT NULL,
  date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES "USER"(user_id),
  FOREIGN KEY (reward_id) REFERENCES REWARD(reward_id)
);

-- Tabla de ranking
CREATE TABLE LEADERBOARD (
  leaderboard_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  position INT NOT NULL,
  total_points INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES "USER"(user_id)
);

-- Preguntas
CREATE TABLE QUESTION (
  question_id INT PRIMARY KEY,
  question_text TEXT,
  question_type question_type_enum
);

-- Relación examen-pregunta
CREATE TABLE EXAM_QUESTION (
  exam_id INT NOT NULL,
  question_id INT NOT NULL,
  PRIMARY KEY (exam_id, question_id),
  FOREIGN KEY (exam_id) REFERENCES EXAM(exam_id),
  FOREIGN KEY (question_id) REFERENCES QUESTION(question_id)
);

-- Opciones de respuesta
CREATE TABLE ANSWER_OPTION (
  option_id INT PRIMARY KEY,
  question_id INT NOT NULL,
  option_text TEXT,
  is_correct BOOLEAN,
  FOREIGN KEY (question_id) REFERENCES QUESTION(question_id)
);

-- Historial de notificaciones
CREATE TABLE NOTIFICATION_HISTORY (
  notification_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  message TEXT,
  sent_date TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES "USER"(user_id)
);

-- Logs del sistema
CREATE TABLE LOG (
  log_id INT PRIMARY KEY,
  timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  user VARCHAR(100) NOT NULL,
  affected_table VARCHAR(100) NOT NULL,
  operation VARCHAR(50) NOT NULL,
  details TEXT
);
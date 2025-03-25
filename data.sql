-- Insertar roles de usuario
INSERT INTO USER_ROLE (role_id, role_name, description) VALUES
(1, 'admin', 'Administrador del sistema'),
(2, 'student', 'Usuario estudiante'),
(3, 'teacher', 'Profesor');

-- Insertar usuarios
INSERT INTO "USER" (user_id, name, email, password, role_id) VALUES
(1, 'Juan Pérez', 'juan@example.com', 'hashed_password1', 2),
(2, 'María Gómez', 'maria@example.com', 'hashed_password2', 2),
(3, 'Carlos López', 'carlos@example.com', 'hashed_password3', 3),
(4, 'Admin User', 'admin@example.com', 'hashed_password4', 1);

-- Insertar categorías de lecciones
INSERT INTO LESSON_CATEGORY (category_id, category_name) VALUES
(1, 'Seguridad Vial'),
(2, 'Normas de Conducción');

-- Insertar lecciones
INSERT INTO LESSON (lesson_id, title, description, difficulty_level, points_awarded) VALUES
(1, 'Señales de Tránsito', 'Aprender las señales de tránsito esenciales', 'simple', 10),
(2, 'Normas de Conducción', 'Reglas básicas de manejo en la vía pública', 'advanced', 15);

-- Relacionar lecciones con categorías
INSERT INTO LESSON_CATEGORY_REL (lesson_id, category_id) VALUES
(1, 1),
(2, 2);

-- Insertar progreso de lecciones
INSERT INTO PROGRESS (progress_id, user_id, lesson_id, status, completion_date) VALUES
(1, 1, 1, 'COMPLETADO', '2025-03-15 10:30:00'),
(2, 2, 1, 'EN PROGRESO', NULL),
(3, 3, 2, 'COMPLETADO', '2025-03-16 12:00:00');

-- Insertar exámenes
INSERT INTO EXAM (exam_id, title, description, difficulty_level, points_awarded) VALUES
(1, 'Examen Básico de Seguridad Vial', 'Evalúa conocimientos básicos de tránsito', 'simple', 20),
(2, 'Examen Avanzado de Normas', 'Examen sobre normativas avanzadas de conducción', 'advanced', 30);

-- Insertar preguntas
INSERT INTO QUESTION (question_id, question_text, question_type) VALUES
(1, '¿Qué significa una señal de alto?', 'multiple_choice'),
(2, '¿Es obligatorio usar el cinturón de seguridad?', 'true_false');

-- Relacionar preguntas con exámenes
INSERT INTO EXAM_QUESTION (exam_id, question_id) VALUES
(1, 1),
(1, 2);

-- Insertar opciones de respuesta
INSERT INTO ANSWER_OPTION (option_id, question_id, option_text, is_correct) VALUES
(1, 1, 'Debe detenerse completamente', TRUE),
(2, 1, 'Debe reducir la velocidad', FALSE),
(3, 2, 'Sí', TRUE),
(4, 2, 'No', FALSE);

-- Insertar progreso de exámenes
INSERT INTO EXAM_PROGRESS (exam_progress_id, user_id, exam_id, status, completion_date) VALUES
(1, 1, 1, 'COMPLETADO', '2025-03-15 14:00:00'),
(2, 2, 1, 'EN PROGRESO', NULL),
(3, 3, 2, 'COMPLETADO', '2025-03-16 16:00:00');

-- Insertar resultados de exámenes
INSERT INTO EXAM_RESULT (exam_result_id, user_id, exam_id, score, date) VALUES
(1, 1, 1, 90, '2025-03-15 14:10:00'),
(2, 3, 2, 85, '2025-03-16 16:10:00');

-- Insertar historial de notificaciones
INSERT INTO NOTIFICATION_HISTORY (notification_id, user_id, message, sent_date) VALUES
(1, 1, 'Has completado la lección de Señales de Tránsito', '2025-03-15 11:00:00'),
(2, 3, 'Nuevo examen disponible: Examen Avanzado de Normas', '2025-03-16 09:30:00');

-- Insertar logs del sistema
INSERT INTO LOG (log_id, timestamp, username, affected_table, operation, details) VALUES
(1, '2025-03-15 11:30:00', 'Juan Pérez', 'PROGRESS', 'UPDATE', 'Actualización de estado de progreso'),
(2, '2025-03-16 10:00:00', 'Carlos López', 'EXAM_RESULT', 'INSERT', 'Nuevo resultado de examen registrado');



-- Задача: определить пользовательские сессии по событиям.
-- Если разрыв между событиями одного пользователя больше 15 минут — 
-- начинается новая сессия. Присвоить каждой сессии уникальный ID.

CREATE TABLE user_activity (
    event_id INT,
    user_id INT,
    event_time TIMESTAMP
);

WITH user_activity_with_lag AS (
    SELECT
        event_id,
        user_id,
        event_time,
        LAG(event_time, 1) OVER(PARTITION BY user_id ORDER BY event_time) AS lag_event_time
    FROM user_activity
),
session_flags AS (
    SELECT 
        event_id,
        user_id,
        event_time,
        CASE
            WHEN event_time - lag_event_time > INTERVAL '15 minutes' 
                OR lag_event_time IS NULL 
            THEN 1 ELSE 0 
        END AS diff_flag
    FROM user_activity_with_lag
),
session_numbers AS (
    SELECT 
        event_id,
        user_id,
        event_time,
        SUM(diff_flag) OVER(PARTITION BY user_id ORDER BY event_time) AS session_number
    FROM session_flags
)
SELECT 
    event_id,
    user_id,
    event_time,
    CONCAT(user_id, '_', session_number) AS uniq_session_id
FROM session_numbers

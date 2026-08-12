-- Задача: найти пары поездок одной и той же машины (car_number), 
-- которые пересекаются по времени (start_time / end_time).
-- Это может указывать на ошибку в данных или подозрительную активность 
-- (одна машина не может физически быть в двух поездках одновременно).

CREATE TABLE taxi_trips (
    trip_id INT,
    driver_id INT,
    car_number VARCHAR(20),
    start_time TIMESTAMP,
    end_time TIMESTAMP
);

SELECT
    t1.driver_id,
    t1.trip_id,
    t2.trip_id
FROM taxi_trips t1
JOIN taxi_trips t2
    ON t1.car_number = t2.car_number
    AND t1.trip_id < t2.trip_id
    AND t1.end_time > t2.start_time
    AND t1.start_time < t2.end_time

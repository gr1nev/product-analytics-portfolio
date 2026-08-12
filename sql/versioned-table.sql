-- Задача: найти заказы, в которых товар стоил больше 300 рублей 
-- на дату заказа (не по текущей цене, а по цене, действовавшей на момент заказа).
-- Таблица items хранит историю изменения цен: каждая строка = 
-- цена, действующая начиная с update_date до следующего изменения.

CREATE TABLE orders (
    order_id INT,
    user_id VARCHAR(10),
    item_id INT,
    order_date DATE
);

CREATE TABLE items (
    item_id INT,
    item_name VARCHAR(50),
    price INT,
    update_date DATE
);

WITH last_version AS (
    SELECT
        order_id,
        o.item_id,
        i.item_name,
        order_date,
        price,
        ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY update_date DESC) AS rn
    FROM orders o 
    LEFT JOIN items i 
        ON o.item_id = i.item_id 
        AND i.update_date <= o.order_date
)
SELECT 
    order_id,
    item_name, 
    price,
    order_date
FROM last_version
WHERE rn = 1 AND price > 300

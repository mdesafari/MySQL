-- select our db
USE country_db;

-- select cities starting by 'Blain'
SELECT city_id, city_name
FROM cities
WHERE city_name LIKE 'Blain%';

-- select our db
USE country_db;

-- let's create a view that read all cities of canada
DROP VIEW IF EXISTS extract_cities_canada;
CREATE VIEW extract_cities_canada AS
SELECT
    c.country_id, c.country_name, i.city_name
FROM countries AS c
INNER JOIN cities AS i
ON c.country_id = i.country_id
WHERE c.country_name = 'canada';

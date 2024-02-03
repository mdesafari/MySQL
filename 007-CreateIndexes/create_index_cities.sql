-- select our db
USE country_db;

-- create an index on city_name
-- here we will create a prefix index
CREATE INDEX idx_city_name
ON cities(city_name(30));

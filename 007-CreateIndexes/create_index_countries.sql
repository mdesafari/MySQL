-- select our db
USE country_db;

-- let's create a unique index on country_name
CREATE UNIQUE INDEX idx_country_name
ON countries(country_name);

-- create another unique index on country_code
CREATE UNIQUE INDEX idx_country_code
ON countries(country_code);


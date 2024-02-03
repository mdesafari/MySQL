-- select our db
USE cleaned_db;

-- drop tables and the db in this order
DROP TABLE IF EXISTS cities;  -- because cities depends on countries
DROP TABLE IF EXISTS countries;  -- because countries depends on currencies
DROP TABLE IF EXISTS currencies;
DROP DATABASE IF EXISTS country_db;

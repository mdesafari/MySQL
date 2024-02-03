-- create a db if not exists
CREATE DATABASE IF NOT EXISTS country_db;

-- select the newly created db
USE country_db;


-- create the different tables
-- 1. create the currencies table
DROP TABLE IF EXISTS currencies;
CREATE TABLE currencies (
    currency_id INT AUTO_INCREMENT PRIMARY KEY,
    currency_name VARCHAR(100) NOT NULL,
    currency_code VARCHAR(3)
);


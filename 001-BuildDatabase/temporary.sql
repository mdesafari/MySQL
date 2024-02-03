-- the objective is to recreate our database but with cleaned data
-- from the previous database

CREATE DATABASE IF NOT EXISTS cleaned_db;
USE cleaned_db;

DROP TABLE IF EXISTS countries;
CREATE TABLE countries(
    country_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50) NOT NULL,
    country_code VARCHAR(50) NOT NULL,
    region VARCHAR(50),
    sub_region VARCHAR(100)
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    currency_id INT,
    -- create our foreign key
    FOREIGN KEY (currency_id) REFERENCES currencies(currency_id)
);

-- insert data in our countries table
-- ensure the data is processed
INSERT INTO countries(
    country_id,
    country_name,
    country_code,
    region,
    sub_region,
    created_on,
    currency_id
)

(
    SELECT
        c.country_id,
        -- ignore all alphanumeric caracters and consider only '. ', then replace by ''
        -- not [] means include and ^ in [] exclude and ^ followed by ^ in [] means include
        -- [abc.] all this elements are considered literal elements because of []
        -- g: global search and i: insensitive to case. e.g., 'Hello. World' => 'HelloWorld'
        -- TRIM: remove space at the beginning and the end of the string
        TRIM(LOWER(REGEXP_REPLACE(c.country_name, '[^[:alnum:][:space:]^. ]', '', 1, 0))),
        TRIM(LOWER(REGEXP_REPLACE(c.country_code, '[^[:alnum:][:space:]^. ]', '', 1, 0))),
        TRIM(LOWER(REGEXP_REPLACE(c.region, '[^[:alnum:][:space:]^. ]', '', 1, 0))),
        TRIM(LOWER(REGEXP_REPLACE(c.sub_region, '[^[:alnum:][:space:]^. ]', '', 1, 0)))
        CURRENT_TIMESTAMP,
        currency_id
    FROM
        country_db.countries AS c
);

-- for cities
DROP TABLE IF EXISTS cities;
CREATE TABLE cities(
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(50) NOT NULL,
    latitude DECIMAL(8, 4),
    longitude DECIMAL(8, 4),
    capital VARCHAR(5),
    population INT,
    inserted TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- create the foreign key
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

INSERT INTO cities(
    city_id,
    city_name,
    latitude,
    longitude,
    capital,
    population,
    inserted,
    coutry_id
)

(
    SELECT
        -- CAST(c.city_name AS CHAR(50)), -- Yes, It cast it into VARCHAR(N). IF N is not specified, then => CHAR
        c.city_id,
        CONCAT(UCASE(LEFT(LOWER(c.city_name), 1)), SUBSTRING(LOWER(c.city_name), 2)),
        CAST(c.latitude AS DECIMAL(8, 4)),
        CAST(c.longitude AS DECIMAL(8, 4)),
        IF(UPPER(TRIM(c.capital)) = 'TRUE', 1, 0),
        CAST(c.population AS UNSIGNED),  -- Use of INT is not allowed here
        CURRENT_TIMESTAMP,
        c.country_id
    FROM
        country_db.cities AS c
);


DROP TABLE IF EXISTS currencies;
CREATE TABLE currencies(
    currency_id INT AUTO_INCREMENT PRIMARY KEY,
    currency_name VARCHAR(100) NOT NULL,
    currency_code VARCHAR(3)
);

INSERT INTO currencies(
    currency_id,
    currency_name,
    currency_code
)

(
    SELECT
        c.currency_id,
        TRIM(LOWER(REGEXP_REPLACE(c.currency_name, '[^[:alnum:][:space:]^. ]', '', 1, 0))),
        TRIM(LOWER(REGEXP_REPLACE(c.currency_code, '[^[:alnum:][:space:]^. ]', '', 1, 0)))
    FROM
        country_db.currencies AS c
);

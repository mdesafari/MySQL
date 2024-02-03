-- select our db
USE country_db;

-- create a stored procedure that retrieves
-- all records of countries, cities or currencies
DROP PROCEDURE IF EXISTS display_table;
CREATE PROCEDURE display_table(IN chosenTable VARCHAR(15))
BEGIN
    -- use a case
    CASE chosenTable
        WHEN 'Countries' THEN
            SELECT country_name, region FROM countries ORDER BY country_name ASC;
        
        WHEN 'Cities' THEN
            SELECT city_name, FORMAT(population, 0) FROM cities ORDER BY city_name ASC;
        
        WHEN 'Canada' THEN
            SELECT * FROM extract_cities_canada;  -- the view acts like a table

        ELSE
            SELECT * FROM currencies;
    END CASE;
END;

-- let's use this procedure
CALL display_table('Cities');



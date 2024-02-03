-- select our db
USE country_db;

/*
List all of the regions and the total number of countries in each region.  
Order by country count in descending order and capitalize the region name.
*/

SELECT
    CONCAT(  
        UCASE(SUBSTRING(region, 1, 1)),  -- get the 1st letter and upcase
        SUBSTRING(region, 2)  -- get the rest of the string
    ) AS region,
    COUNT(country_name) AS nb_countries
FROM
    countries
GROUP BY
    region
ORDER BY
    nb_countries DESC
;


/*
List all of the sub-regions and the total number of cities in each sub-region.  
Order by sub-region name alphabetically.
*/

SELECT
    c.sub_region,
    COUNT(i.city_name) AS nb_cities
FROM countries AS c
INNER JOIN cities AS i
ON c.country_id = i.country_id
GROUP BY c.sub_region
ORDER BY c.sub_region ASC
;


/*
List all of the countries and the total number of cities in the Southern 
Europe sub-region that were inserted in 2021 or more.  
Capitalize the country names and order alphabetically 
by the **LAST** letter of the country name and the number of cities.
*/

SELECT
    CONCAT(
        UCASE(SUBSTRING(c.country_name, 1, 1)), 
        SUBSTRING(c.country_name, 2)
    ) AS country_name,
    COUNT(i.city_name) AS nb_cities
FROM countries AS c
INNER JOIN cities AS i
ON c.country_id = i.country_id
WHERE c.sub_region = 'southern europe' AND EXTRACT(YEAR FROM c.created_on) >= 2021
GROUP BY c.country_name
ORDER BY SUBSTRING(c.country_name, -1) ASC, nb_cities ASC
;

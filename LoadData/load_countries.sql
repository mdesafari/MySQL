-- select our db
USE country_db;

-- load data from a csv file
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Data/ProjectMySQL/countries.csv'
INTO TABLE countries
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`country_id`, `country_name`, `country_code`, `region`, `sub_region`, `currency_id`);

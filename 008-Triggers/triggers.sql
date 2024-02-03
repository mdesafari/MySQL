-- select our db
USE country_db;

-- create a table to monitor the changes made to our table
-- here we will monitor entries in cities table
CREATE TABLE IF NOT EXISTS city_remote_insert (
    city_remote_id INT AUTO_INCREMENT PRIMARY KEY,
    change_type VARCHAR(10),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- now create the trigger
CREATE TRIGGER IF NOT EXISTS insert_city_trigger
AFTER INSERT
ON cities
FOR EACH ROW
BEGIN
    INSERT INTO city_remote_insert (city_id, change_type)
    VALUES (NEW.city_id, 'INSERT');  -- NEW here reference the inserted record
END;

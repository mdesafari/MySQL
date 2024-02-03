-- select our db
USE country_db;

-- let's create a multiple index using both currency_name
-- and currency_code
CREATE INDEX idx_currency
ON currencies(currency_name, currency_code);

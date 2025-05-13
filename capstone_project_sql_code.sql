ALTER TABLE salary ds_salaries
ADD salary_currency_fullform VARCHAR(100);

ALTER TABLE ds_salaries_new
ADD remote_ratio_fullform VARCHAR(100);

ALTER TABLE ds_salaries_new
RENAME COLUMN salary TO salary_in_INR;

ALTER TABLE ds_salaries_new
ADD monthly_salary INT;

ALTER TABLE ds_salaries_new ADD continent VARCHAR(50);

SELECT * FROM ds_salaries_new;

SET SQL_SAFE_UPDATES = 0;
update ds_salaries_new
set remote_ratio_fullform = 
CASE remote_ratio
when 100 then 'remote job'
when 50 then 'hybrid job'
when 0 then 'office job'
else 'office job'
end;

UPDATE ds_salaries_new
SET salary = salary_in_usd*83.22;

UPDATE ds_salaries_new
SET salary_currency_fullform= 
    CASE salary_currency
        WHEN 'EUR' THEN 'Euro'
        WHEN 'USD' THEN 'United States Dollar'
        WHEN 'INR' THEN 'Indian Rupee'
        WHEN 'HKD' THEN 'Hong Kong Dollar'
        WHEN 'CHF' THEN 'Swiss Franc'
        WHEN 'GBP' THEN 'Great British Pound'
        WHEN 'AUD' THEN 'Australian Dollar'
        WHEN 'SGD' THEN 'Singapore Dollar'
        WHEN 'CAD' THEN 'Canadian Dollar'
        WHEN 'ILS' THEN 'Israeli New Shekel'
        WHEN 'BRL' THEN 'Brazilian Real'
        WHEN 'THB' THEN 'Thai Baht'
        WHEN 'PLN' THEN 'Polish Zloty'
        WHEN 'HUF' THEN 'Hungarian Forint'
        WHEN 'CZK' THEN 'Czech Koruna'
        WHEN 'DKK' THEN 'Danish Krone'
        WHEN 'JPY' THEN 'Japanese Yen'
        WHEN 'MXN' THEN 'Mexican Peso'
        WHEN 'TRY' THEN 'Turkish Lira'
        WHEN 'CLP' THEN 'Chilean Peso'
        ELSE 'Unknown'
    END;
    
        
    UPDATE ds_salaries_new
SET continent = CASE
    WHEN company_location IN ('IN', 'CN', 'JP', 'SG') THEN 'Asia'
    WHEN company_location IN ('NG', 'ZA', 'EG', 'KE') THEN 'Africa'
    WHEN company_location IN ('US', 'CA', 'MX') THEN 'North America'
    WHEN company_location IN ('GB', 'FR', 'DE') THEN 'Europe'
    ELSE 'Other'
END;
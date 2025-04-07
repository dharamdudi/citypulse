CREATE DATABASE IF NOT EXISTS raw;
CREATE DATABASE IF NOT EXISTS development;
CREATE DATABASE IF NOT EXISTS ci;
CREATE DATABASE IF NOT EXISTS production;

CREATE ROLE IF NOT EXISTS dev_role;
CREATE ROLE IF NOT EXISTS ci_role;
CREATE ROLE IF NOT EXISTS prod_role;

CREATE SCHEMA IF NOT EXISTS raw.yelp;
CREATE SCHEMA IF NOT EXISTS development.yelp;

CREATE WAREHOUSE IF NOT EXISTS dev_wh WITH WAREHOUSE_SIZE = 'XSMALL';
CREATE WAREHOUSE IF NOT EXISTS ci_wh WITH WAREHOUSE_SIZE = 'XSMALL';
CREATE WAREHOUSE IF NOT EXISTS prod_wh WITH WAREHOUSE_SIZE = 'XSMALL';

GRANT USAGE ON WAREHOUSE dev_wh TO ROLE dev_role;
GRANT USAGE ON WAREHOUSE ci_wh TO ROLE ci_role;
GRANT USAGE ON WAREHOUSE prod_wh TO ROLE prod_role;

GRANT ROLE dev_role TO USER {user_name};
GRANT ROLE ci_role TO USER {user_name};
GRANT ROLE prod_role TO USER {user_name};


GRANT USAGE ON DATABASE raw TO ROLE dev_role;
GRANT USAGE ON SCHEMA raw.public TO ROLE dev_role;
GRANT SELECT ON ALL TABLES IN SCHEMA raw.public TO ROLE dev_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA raw.public TO ROLE dev_role;
GRANT USAGE ON SCHEMA raw.yelp TO ROLE dev_role;
GRANT SELECT ON ALL TABLES IN SCHEMA raw.yelp TO ROLE dev_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA raw.yelp TO ROLE dev_role;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE raw TO ROLE dev_role;
GRANT SELECT ON ALL VIEWS IN DATABASE RAW TO ROLE ci_role;
GRANT SELECT ON FUTURE VIEWS IN DATABASE RAW TO ROLE ci_role;

GRANT USAGE ON DATABASE raw TO ROLE ci_role;
GRANT USAGE ON SCHEMA raw.public TO ROLE ci_role;
GRANT SELECT ON ALL TABLES IN SCHEMA raw.public TO ROLE ci_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA raw.public TO ROLE ci_role;
GRANT USAGE ON SCHEMA raw.yelp TO ROLE ci_role;
GRANT SELECT ON ALL TABLES IN SCHEMA raw.yelp TO ROLE ci_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA raw.yelp TO ROLE ci_role;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE raw TO ROLE ci_role;
GRANT SELECT ON ALL VIEWS IN DATABASE RAW TO ROLE ci_role;
GRANT SELECT ON FUTURE VIEWS IN DATABASE RAW TO ROLE ci_role;

GRANT ALL PRIVILEGES ON DATABASE raw TO ROLE prod_role;
GRANT ALL PRIVILEGES ON SCHEMA raw.public TO ROLE prod_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA raw.public TO ROLE prod_role;
GRANT ALL PRIVILEGES ON FUTURE TABLES IN SCHEMA raw.public TO ROLE prod_role;
GRANT ALL PRIVILEGES ON SCHEMA raw.yelp TO ROLE prod_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA raw.yelp TO ROLE prod_role;
GRANT ALL PRIVILEGES ON FUTURE TABLES IN SCHEMA raw.yelp TO ROLE prod_role;
GRANT ALL PRIVILEGES ON FUTURE SCHEMAS IN DATABASE raw TO ROLE prod_role;

GRANT ALL PRIVILEGES ON DATABASE development TO ROLE dev_role;
GRANT ALL PRIVILEGES ON SCHEMA development.public TO ROLE dev_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA development.public TO ROLE dev_role;
GRANT ALL PRIVILEGES ON FUTURE TABLES IN SCHEMA development.public TO ROLE dev_role;
GRANT ALL PRIVILEGES ON FUTURE SCHEMAS IN DATABASE development TO ROLE dev_role;

GRANT ALL PRIVILEGES ON DATABASE development TO ROLE prod_role;
GRANT ALL PRIVILEGES ON SCHEMA development.public TO ROLE prod_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA development.public TO ROLE prod_role;
GRANT ALL PRIVILEGES ON FUTURE TABLES IN SCHEMA development.public TO ROLE prod_role;
GRANT ALL PRIVILEGES ON FUTURE SCHEMAS IN DATABASE development TO ROLE prod_role;

GRANT ALL PRIVILEGES ON DATABASE ci TO ROLE ci_role;
GRANT ALL PRIVILEGES ON SCHEMA ci.public TO ROLE ci_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ci.public TO ROLE ci_role;
GRANT ALL PRIVILEGES ON FUTURE TABLES IN SCHEMA ci.public TO ROLE ci_role;
GRANT ALL PRIVILEGES ON FUTURE SCHEMAS IN DATABASE ci TO ROLE ci_role;

GRANT ALL PRIVILEGES ON DATABASE ci TO ROLE prod_role;
GRANT ALL PRIVILEGES ON SCHEMA ci.public TO ROLE prod_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ci.public TO ROLE prod_role;
GRANT ALL PRIVILEGES ON FUTURE TABLES IN SCHEMA ci.public TO ROLE prod_role;
GRANT ALL PRIVILEGES ON FUTURE SCHEMAS IN DATABASE ci TO ROLE prod_role;

GRANT ALL PRIVILEGES ON DATABASE production TO ROLE prod_role;
GRANT ALL PRIVILEGES ON SCHEMA production.public TO ROLE prod_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA production.public TO ROLE prod_role;
GRANT ALL PRIVILEGES ON FUTURE TABLES IN SCHEMA production.public TO ROLE prod_role;
GRANT ALL PRIVILEGES ON FUTURE SCHEMAS IN DATABASE production TO ROLE prod_role;

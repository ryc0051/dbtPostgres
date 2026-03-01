-- Grant access to existing tables
--GRANT SELECT ON ALL TABLES IN SCHEMA schema_name TO user_or_role;

-- Grant access to future tables
--ALTER DEFAULT PRIVILEGES IN SCHEMA schema_name
--GRANT SELECT ON TABLES TO user_or_role;

-- Grant usage on sequences (needed for serial/identity columns)
--GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA schema_name TO user_or_role;


-------------------------------------------------------------------------------------------------------------------------------------

-- Create Medallion Architecture
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;


-- Deployment Group : deployrole
-- Assigned CI/CD accounts for deployment create permission on 
CREATE ROLE deployrole WITH NOLOGIN;


GRANT CONNECT ON DATABASE dbt TO deployrole;


-- Bronze


-- Create  on schema
GRANT USAGE ,CREATE ON SCHEMA bronze TO deployrole;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA bronze  TO deployrole;


-- Grant Select,Insert etc to all existing resources in schema
ALTER DEFAULT PRIVILEGES IN SCHEMA bronze
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO deployrole;

-- 
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA bronze TO deployrole;
ALTER DEFAULT PRIVILEGES IN SCHEMA bronze
  GRANT USAGE, SELECT ON SEQUENCES TO deployrole;




-- Silver
GRANT USAGE ,CREATE ON SCHEMA silver TO deployrole;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA silver TO deployrole;

ALTER DEFAULT PRIVILEGES IN SCHEMA silver
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO deployrole;

GRANT USAGE, 
SELECT ON ALL SEQUENCES IN SCHEMA silver TO deployrole;
ALTER DEFAULT PRIVILEGES IN SCHEMA silver
  GRANT USAGE, SELECT ON SEQUENCES TO deployrole;


-- Gold
GRANT USAGE ,CREATE ON SCHEMA gold TO deployrole;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA gold TO deployrole;

GRANT USAGE, 
SELECT ON ALL SEQUENCES IN SCHEMA gold TO deployrole;
ALTER DEFAULT PRIVILEGES IN SCHEMA gold
  GRANT USAGE, SELECT ON SEQUENCES TO deployrole;


-----------------------------------------------------------------------------------------------------------------

CREATE USER dbtworking WITH LOGIN  PASSWORD '';

GRANT  deployrole TO dbtworking; 







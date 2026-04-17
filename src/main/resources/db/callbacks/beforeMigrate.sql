-- Runs before any migration scripts are executed. This is where you should put cleanup logic.
-- Remove failed entries so Flyway treats them as new attempts
-- This runs EVERY time the app starts, before Flyway looks at V1, V2, or V3.
-- It removes the 'Failed' record so Flyway attempts the fixed version.
SELECT 'Before Migration -started' AS 'C6';
SELECT * FROM flyway_schema_history_demo_service;
DELETE FROM flyway_schema_history_demo_service WHERE success = 0;
SELECT * FROM flyway_schema_history_demo_service;
SELECT 'Before Migration -completed' AS 'C6';

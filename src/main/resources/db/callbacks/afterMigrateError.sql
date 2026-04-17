-- Log the failure to a custom table for auditing
CREATE TABLE IF NOT EXISTS migration_error_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    failed_version VARCHAR(50),
    error_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO migration_error_logs (failed_version) VALUES ('Migration Failed - Check Console Logs');

SELECT 'After Migration Error' AS 'C3';
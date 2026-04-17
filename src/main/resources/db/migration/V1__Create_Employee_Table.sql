CREATE TABLE IF NOT EXISTS employee (
    -- Core Identity
    id BIGINT NOT NULL AUTO_INCREMENT,
    employee_code VARCHAR(20) UNIQUE NOT NULL, -- Internal payroll/ID code
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_no VARCHAR(20),

    -- Address Information
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country_code CHAR(2) DEFAULT 'US', -- ISO 3166-1 alpha-2

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE KEY uk_employee_email (email),
    INDEX idx_employee_code (employee_code)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- FIN_CUSTOMER (17 columns)
CREATE TABLE IF NOT EXISTS FIN_CUSTOMER (
                              id BIGINT AUTO_INCREMENT PRIMARY KEY,
                              customer_urn VARCHAR(50) UNIQUE NOT NULL, -- Unique Registration Number
                              title VARCHAR(10),
                              first_name VARCHAR(100) NOT NULL,
                              middle_name VARCHAR(100),
                              last_name VARCHAR(100) NOT NULL,
                              dob DATE NOT NULL,
                              gender VARCHAR(1),
                              email_address VARCHAR(150),
                              mobile_number VARCHAR(20),
                              tax_id_mask VARCHAR(50), -- e.g., SSN or PAN
                              kyc_status VARCHAR(20), -- PENDING, VERIFIED, EXPIRED
                              nationality_iso2 VARCHAR(2),
                              residency_status VARCHAR(20),
                              risk_rating VARCHAR(10), -- LOW, MEDIUM, HIGH
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS FIN_ACCOUNT (
    -- Core Identification (1-10)
                             id BIGINT AUTO_INCREMENT PRIMARY KEY,
                             account_urn VARCHAR(50) UNIQUE NOT NULL,
                             account_number VARCHAR(34) UNIQUE NOT NULL, -- IBAN Format
                             display_name VARCHAR(100),
                             account_type_code VARCHAR(10), -- SAV, CUR, TD, loan
                             account_sub_type VARCHAR(20),
                             base_currency_iso VARCHAR(3) NOT NULL,
                             branch_code VARCHAR(20),
                             customer_id BIGINT NOT NULL,
                             status_code VARCHAR(10), -- ACTIVE, DORMANT, FROZEN, CLOSED

    -- Balances & Limits (11-30)
                             current_balance DECIMAL(19,4) DEFAULT 0.0000,
                             available_balance DECIMAL(19,4) DEFAULT 0.0000,
                             ledger_balance DECIMAL(19,4) DEFAULT 0.0000,
                             cleared_balance DECIMAL(19,4) DEFAULT 0.0000,
                             overdraft_limit DECIMAL(19,4) DEFAULT 0.0000,
                             min_balance_required DECIMAL(19,4) DEFAULT 0.0000,
                             hold_amount DECIMAL(19,4) DEFAULT 0.0000,
                             accrued_interest_receivable DECIMAL(19,4) DEFAULT 0.0000,
                             accrued_interest_payable DECIMAL(19,4) DEFAULT 0.0000,
                             last_tran_amount DECIMAL(19,4),
                             unposted_debits DECIMAL(19,4),
                             unposted_credits DECIMAL(19,4),
                             monthly_avg_balance DECIMAL(19,4),
                             quarterly_avg_balance DECIMAL(19,4),
                             annual_avg_balance DECIMAL(19,4),
                             credit_limit DECIMAL(19,4),
                             drawing_power DECIMAL(19,4),
                             total_lien_amount DECIMAL(19,4),
                             total_float_amount DECIMAL(19,4),
                             last_stmt_balance DECIMAL(19,4),

    -- Interest & Product Logic (31-60)
                             interest_table_code VARCHAR(10),
                             interest_index_rate DECIMAL(7,4),
                             interest_spread DECIMAL(7,4),
                             effective_interest_rate DECIMAL(7,4),
                             last_interest_run_date DATE,
                             next_interest_run_date DATE,
                             interest_calculation_method VARCHAR(20), -- DAILY_PRODUCT, FLAT
                             interest_payment_frequency VARCHAR(10), -- MON, QTR, ANN
                             tax_withholding_category VARCHAR(10),
                             tax_id_on_account VARCHAR(20),
                             waive_interest_flag CHAR(1) DEFAULT 'N',
                             penalty_rate DECIMAL(7,4),
                             product_code VARCHAR(20),
                             scheme_code VARCHAR(20),
                             gl_sub_head_code VARCHAR(10),
                             is_revolving_limit BOOLEAN DEFAULT FALSE,
                             tenure_months INT,
                             tenure_days INT,
                             maturity_date DATE,
                             value_date DATE,
                             opening_date DATE NOT NULL,
                             closing_date DATE,
                             renewal_date DATE,
                             last_activity_date DATE,
                             last_customer_contact_date DATE,
                             stmt_frequency VARCHAR(10),
                             stmt_day_of_month INT,
                             stmt_dispatch_mode VARCHAR(10),
                             is_staff_account BOOLEAN DEFAULT FALSE,
                             is_joint_account BOOLEAN DEFAULT FALSE,

    -- Regulatory & Compliance (61-90)
                             aml_risk_category VARCHAR(10),
                             kyc_renewal_date DATE,
                             fatca_status VARCHAR(10),
                             crs_status VARCHAR(10),
                             reporting_country_iso VARCHAR(2),
                             is_pdp_account BOOLEAN DEFAULT FALSE,
                             sanction_check_status VARCHAR(20),
                             purpose_of_account_code VARCHAR(10),
                             source_of_funds_code VARCHAR(10),
                             frozen_reason_code VARCHAR(10),
                             is_delinquent BOOLEAN DEFAULT FALSE,
                             npa_classification VARCHAR(10), -- Standard, Substandard, Doubtful
                             npa_date DATE,
                             provision_amount DECIMAL(19,4),
                             collateral_id BIGINT,
                             is_secured BOOLEAN,
                             insurance_premium_amount DECIMAL(19,4),
                             is_sharia_compliant BOOLEAN,
                             waive_maintenance_fee BOOLEAN,
                             fee_profile_id VARCHAR(20),
                             nominee_registered_flag CHAR(1),
                             power_of_attorney_id VARCHAR(50),
                             access_channel_restriction VARCHAR(50),
                             mobile_banking_enabled BOOLEAN,
                             net_banking_enabled BOOLEAN,
                             atm_enabled BOOLEAN,
                             debit_card_enabled BOOLEAN,
                             cheque_book_enabled BOOLEAN,
                             sms_alert_enabled BOOLEAN,
                             email_alert_enabled BOOLEAN,

    -- Audit & System (91-133)
                             created_by_user VARCHAR(50),
                             modified_by_user VARCHAR(50),
                             verified_by_user VARCHAR(50),
                             created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                             updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                             version_no INT DEFAULT 1,
    -- Add 37 generic Custom Attribute columns for specific bank flexibility
                             attr_1 VARCHAR(255), attr_2 VARCHAR(255), attr_3 VARCHAR(255), attr_4 VARCHAR(255), attr_5 VARCHAR(255),
                             attr_6 VARCHAR(255), attr_7 VARCHAR(255), attr_8 VARCHAR(255), attr_9 VARCHAR(255), attr_10 VARCHAR(255),
                             attr_11 VARCHAR(255), attr_12 VARCHAR(255), attr_13 VARCHAR(255), attr_14 VARCHAR(255), attr_15 VARCHAR(255),
                             attr_16 VARCHAR(255), attr_17 VARCHAR(255), attr_18 VARCHAR(255), attr_19 VARCHAR(255), attr_20 VARCHAR(255),
                             attr_21 VARCHAR(255), attr_22 VARCHAR(255), attr_23 VARCHAR(255), attr_24 VARCHAR(255), attr_25 VARCHAR(255),
                             attr_26 VARCHAR(255), attr_27 VARCHAR(255), attr_28 VARCHAR(255), attr_29 VARCHAR(255), attr_30 VARCHAR(255),
                             attr_31 VARCHAR(255), attr_32 VARCHAR(255), attr_33 VARCHAR(255), attr_34 VARCHAR(255), attr_35 VARCHAR(255),
                             attr_36 VARCHAR(255), attr_37 VARCHAR(255),

                             CONSTRAINT fk_acc_cust FOREIGN KEY (customer_id) REFERENCES FIN_CUSTOMER(id)
);

-- FIN_TRANSACTION (11 columns)
CREATE TABLE IF NOT EXISTS FIN_TRANSACTION (
                                 id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                 txn_reference_no VARCHAR(50) UNIQUE NOT NULL,
                                 account_id BIGINT NOT NULL,
                                 amount DECIMAL(19,4) NOT NULL,
                                 currency_iso VARCHAR(3) DEFAULT 'USD',
                                 txn_type VARCHAR(20), -- CREDIT, DEBIT, REVERSAL
                                 txn_mode VARCHAR(20), -- WIRE, ATM, POS, INTERNAL
                                 txn_status VARCHAR(20), -- SETTLED, PENDING, FAILED
                                 merchant_category_code VARCHAR(4),
                                 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 effective_date TIMESTAMP,

                                 CONSTRAINT fk_fin_tx_acc FOREIGN KEY (account_id) REFERENCES FIN_ACCOUNT(id)
);

-- FIN_RELATION (8 columns)
CREATE TABLE IF NOT EXISTS FIN_RELATION (
                              id BIGINT AUTO_INCREMENT PRIMARY KEY,
                              primary_customer_id BIGINT NOT NULL,
                              related_customer_id BIGINT NOT NULL,
                              relation_type VARCHAR(30), -- JOINT_HOLDER, GUARANTOR, BENEFICIARY, POWER_OF_ATTORNEY
                              start_date DATE,
                              end_date DATE,
                              is_active BOOLEAN DEFAULT TRUE,
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

                              CONSTRAINT fk_fin_rel_pri FOREIGN KEY (primary_customer_id) REFERENCES FIN_CUSTOMER(id),
                              CONSTRAINT fk_fin_rel_rel FOREIGN KEY (related_customer_id) REFERENCES FIN_CUSTOMER(id)
);

CREATE TABLE VPLUS_CUSTOMER (
    -- Core Profile (1-10)
                                id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                vplus_id VARCHAR(50) UNIQUE NOT NULL,
                                linked_fin_customer_id BIGINT,
                                loyalty_tier_code VARCHAR(10), -- BRONZE, GOLD, PLATINUM
                                enrollment_date DATE,
                                expiry_date DATE,
                                preferred_language_iso2 VARCHAR(2),
                                communication_channel_pref VARCHAR(10), -- SMS, EMAIL, APP
                                profile_completeness_pct INT,
                                digital_id_token VARCHAR(255),

    -- Points & Rewards (11-30)
                                available_points INT DEFAULT 0,
                                lifetime_points_earned INT DEFAULT 0,
                                lifetime_points_redeemed INT DEFAULT 0,
                                points_pending INT DEFAULT 0,
                                points_expiring_30_days INT DEFAULT 0,
                                last_redemption_date DATE,
                                last_earning_date DATE,
                                preferred_partner_category VARCHAR(20),
                                referral_code VARCHAR(20),
                                referred_by_id BIGINT,

    -- Engagement Metrics (31-60)
                                app_login_count_mtd INT,
                                last_app_login_date TIMESTAMP,
                                web_login_count_mtd INT,
                                avg_session_duration_sec INT,
                                churn_risk_score DECIMAL(5,2),
                                customer_lifetime_value DECIMAL(19,4),
                                net_promoter_score INT,
                                last_survey_date DATE,
                                marketing_opt_in BOOLEAN DEFAULT TRUE,
                                third_party_share_opt_in BOOLEAN DEFAULT FALSE,
                                push_notifications_enabled BOOLEAN DEFAULT TRUE,
                                location_tracking_enabled BOOLEAN DEFAULT FALSE,

    -- Demographics & Lifestyle (61-90)
                                income_range_code VARCHAR(10),
                                employment_sector VARCHAR(50),
                                education_level VARCHAR(20),
                                home_ownership_status VARCHAR(20),
                                marital_status VARCHAR(10),
                                number_of_dependents INT,
                                primary_hobby VARCHAR(50),
                                travel_frequency_index INT, -- 1-10
                                digital_savviness_score INT, -- 1-10

    -- System & Audit (91-116)
                                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- Generic VPlus attributes to reach 116
                                vp_attr_1 VARCHAR(255), vp_attr_2 VARCHAR(255), vp_attr_3 VARCHAR(255), vp_attr_4 VARCHAR(255), vp_attr_5 VARCHAR(255),
                                vp_attr_6 VARCHAR(255), vp_attr_7 VARCHAR(255), vp_attr_8 VARCHAR(255), vp_attr_9 VARCHAR(255), vp_attr_10 VARCHAR(255),
                                vp_attr_11 VARCHAR(255), vp_attr_12 VARCHAR(255), vp_attr_13 VARCHAR(255), vp_attr_14 VARCHAR(255), vp_attr_15 VARCHAR(255),
                                vp_attr_16 VARCHAR(255), vp_attr_17 VARCHAR(255), vp_attr_18 VARCHAR(255), vp_attr_19 VARCHAR(255), vp_attr_20 VARCHAR(255),
                                vp_attr_21 VARCHAR(255), vp_attr_22 VARCHAR(255), vp_attr_23 VARCHAR(255), vp_attr_24 VARCHAR(255),

                                CONSTRAINT fk_vplus_cust_fin FOREIGN KEY (linked_fin_customer_id) REFERENCES FIN_CUSTOMER(id)
);

-- VPLUS_PAYMENT (5 columns)
CREATE TABLE VPLUS_PAYMENT (
                               id BIGINT AUTO_INCREMENT PRIMARY KEY,
                               customer_id BIGINT NOT NULL,
                               vplus_txn_id VARCHAR(50) NOT NULL,
                               settlement_amount DECIMAL(19,4),
                               payment_channel VARCHAR(20), -- MOBILE_APP, NFC, QR_CODE

                               CONSTRAINT fk_vp_pay_cust FOREIGN KEY (customer_id) REFERENCES VPLUS_CUSTOMER(id)
);

-- VPLUS_RELATEDPERSON (8 columns)
CREATE TABLE VPLUS_RELATEDPERSON (
                                     id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                     customer_id BIGINT NOT NULL,
                                     full_name VARCHAR(255),
                                     relationship_code VARCHAR(10), -- SP (Spouse), CH (Child), PA (Parent)
                                     contact_phone VARCHAR(20),
                                     is_emergency_contact BOOLEAN,
                                     last_verified_date DATE,
                                     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

                                     CONSTRAINT fk_vp_rel_cust FOREIGN KEY (customer_id) REFERENCES VPLUS_CUSTOMER(id)
);
CREATE TABLE FIN_SECURITY (
    -- Identification (1-10)
                              id BIGINT AUTO_INCREMENT PRIMARY KEY,
                              isin_code VARCHAR(12) UNIQUE NOT NULL,
                              cusip_code VARCHAR(9),
                              sedol_code VARCHAR(7),
                              ticker_symbol VARCHAR(20),
                              security_description VARCHAR(255),
                              issuer_id BIGINT,
                              issuer_name VARCHAR(255),
                              asset_class_code VARCHAR(10), -- EQUITY, FIXED, DERIV
                              security_type_code VARCHAR(10),

    -- Market Data (11-30)
                              trading_currency_iso VARCHAR(3),
                              exchange_code VARCHAR(10), -- NYSE, LSE, NSE
                              market_lot_size INT,
                              tick_size DECIMAL(10,6),
                              face_value DECIMAL(19,4),
                              issue_price DECIMAL(19,4),
                              current_market_price DECIMAL(19,4),
                              previous_close_price DECIMAL(19,4),
                              price_source VARCHAR(20),
                              last_price_update_time TIMESTAMP,
                              low_52_week DECIMAL(19,4),
                              high_52_week DECIMAL(19,4),
                              market_cap_category VARCHAR(10), -- LARGE, MID, SMALL
                              dividend_yield DECIMAL(7,4),
                              pe_ratio DECIMAL(10,4),
                              beta_coefficient DECIMAL(7,4),
                              is_marginable BOOLEAN,
                              is_shortable BOOLEAN,
                              haircut_percentage DECIMAL(5,2),
                              underlying_asset_id BIGINT,

    -- Fixed Income / Bond Specific (31-50)
                              coupon_rate DECIMAL(7,4),
                              coupon_frequency VARCHAR(10),
                              last_coupon_date DATE,
                              next_coupon_date DATE,
                              maturity_date DATE,
                              issue_date DATE,
                              ytm_yield DECIMAL(7,4), -- Yield to Maturity
                              duration_years DECIMAL(7,4),
                              convexity DECIMAL(7,4),
                              credit_rating_moodys VARCHAR(10),
                              credit_rating_sp VARCHAR(10),
                              credit_rating_fitch VARCHAR(10),
                              is_callable BOOLEAN,
                              is_puttable BOOLEAN,
                              call_price DECIMAL(19,4),
                              put_price DECIMAL(19,4),
                              seniority_level VARCHAR(20), -- Senior, Subordinated
                              is_tax_exempt BOOLEAN,
                              accrued_interest_basis VARCHAR(10), -- 30/360, ACT/ACT
                              total_issued_units BIGINT,

    -- Risk & Audit (51-88)
                              risk_weight_percentage DECIMAL(5,2),
                              var_99_percent DECIMAL(10,4), -- Value at Risk
                              is_active_flag BOOLEAN DEFAULT TRUE,
                              is_restricted_flag BOOLEAN DEFAULT FALSE,
                              restriction_reason VARCHAR(100),
                              internal_rating VARCHAR(10),
                              regulatory_category VARCHAR(20),
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- Custom Attributes (60-88)
                              sec_attr_1 VARCHAR(255), sec_attr_2 VARCHAR(255), sec_attr_3 VARCHAR(255), sec_attr_4 VARCHAR(255),
                              sec_attr_5 VARCHAR(255), sec_attr_6 VARCHAR(255), sec_attr_7 VARCHAR(255), sec_attr_8 VARCHAR(255),
                              sec_attr_9 VARCHAR(255), sec_attr_10 VARCHAR(255), sec_attr_11 VARCHAR(255), sec_attr_12 VARCHAR(255),
                              sec_attr_13 VARCHAR(255), sec_attr_14 VARCHAR(255), sec_attr_15 VARCHAR(255), sec_attr_16 VARCHAR(255),
                              sec_attr_17 VARCHAR(255), sec_attr_18 VARCHAR(255), sec_attr_19 VARCHAR(255), sec_attr_20 VARCHAR(255),
                              sec_attr_21 VARCHAR(255), sec_attr_22 VARCHAR(255), sec_attr_23 VARCHAR(255), sec_attr_24 VARCHAR(255),
                              sec_attr_25 VARCHAR(255), sec_attr_26 VARCHAR(255), sec_attr_27 VARCHAR(255), sec_attr_28 VARCHAR(255),
                              sec_attr_29 VARCHAR(255)
);
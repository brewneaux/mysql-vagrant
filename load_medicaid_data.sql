SET GLOBAL local_infile = 'ON';
# hospital_information
DROP TABLE IF EXISTS hospital_information;
CREATE TABLE hospital_information (
    provider_id varchar(10),
    hospital_name varchar(255),
    address varchar(255),
    city varchar(255),
    state char(2),
    zip varchar(255),
    county_name varchar(255),
    phone_number varchar(255),
    hospital_type varchar(255),
    hospital_ownership varchar(255),
    emergency_services varchar(255),
    PRIMARY KEY (provider_id)
);
LOAD DATA LOCAL INFILE
'/home/vagrant/medicaid/hospital/Hospital_General_Information.csv'
INTO TABLE hospital_information
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS hopsital_healthcare_related_infections;
CREATE TABLE hopsital_healthcare_related_infections (
    provider_id varchar(255),
    measure_name varchar(255),
    measure_id varchar(255),
    compared_to_national varchar(255),
    score varchar(255),
    footnote varchar(255),
    measure_start_date date,
    measure_end_date date,
    KEY (provider_id),
    KEY (measure_id),
    KEY (measure_name)
);
LOAD DATA LOCAL INFILE
'/home/vagrant/medicaid/hospital/Healthcare_Associated_Infections_Hospital.csv'
INTO TABLE hopsital_healthcare_related_infections
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(
    provider_id,
    @hospital_name,
    @address,
    @city,
    @state,
    @zip_code,
    @county_name,
    @phone_number,
    measure_name,
    measure_id,
    compared_to_national,
    score,
    footnote,
    @measure_start_date,
    @measure_end_date
)
SET
    measure_start_date = STR_TO_DATE(@measure_start_date, '%m/%d/%Y'),
    measure_end_date = STR_TO_DATE(@measure_end_date, '%m/%d/%Y')
;

DROP TABLE IF EXISTS hospital_spending_per_patient;
CREATE TABLE hospital_spending_per_patient (
    provider_id varchar(255),
    measure_name varchar(255),
    measure_id varchar(255),
    score varchar(255),
    footnote varchar(255),
    measure_start_date date,
    measure_end_date date,
    KEY (provider_id),
    KEY (measure_name),
    KEY (measure_id)
);
LOAD DATA LOCAL INFILE
'/home/vagrant/medicaid/hospital/Medicare_Hospital_Spending_per_Patient_Hospital.csv'
INTO TABLE hospital_spending_per_patient
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(
    provider_id,
    @hospital_name,
    @address,
    @city,
    @state,
    @zip_code,
    @county_name,
    @phone_number,
    measure_name,
    measure_id,
    score,
    footnote,
    @measure_start_date,
    @measure_end_date
)
SET
    measure_start_date = STR_TO_DATE(@measure_start_date, '%m/%d/%Y'),
    measure_end_date = STR_TO_DATE(@measure_end_date, '%m/%d/%Y')
;

DROP TABLE IF EXISTS hospital_timely_and_effective_care;
CREATE TABLE hospital_timely_and_effective_care (
    provider_id varchar(255),
    measure_name varchar(255),
    measure_id varchar(255),
    cond varchar(255),
    score varchar(255),
    footnote varchar(255),
    sample int,
    measure_start_date date,
    measure_end_date date,
    KEY (provider_id),
    KEY (measure_name),
    KEY (measure_id)
);
LOAD DATA LOCAL INFILE
'/home/vagrant/medicaid/hospital/Timely_and_Effective_Care_Hospital.csv'
INTO TABLE hospital_timely_and_effective_care
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(
    provider_id,
    @hospital_name,
    @address,
    @city,
    @state,
    @zip_code,
    @county_name,
    @phone_number,
    cond,
    measure_id,
    measure_name,
    score,
    @sample,
    footnote,
    @measure_start_date,
    @measure_end_date
)
SET
    sample = IF(@sample LIKE '%not%' OR @sample = '', 0, @sample),
    measure_start_date = IF(@measure_start_date REGEXP '[0-9]+/[0-9]+/[0-9]', STR_TO_DATE(@measure_start_date, '%m/%d/%Y'), '0000-00-00'),
    measure_end_date = IF(@measure_end_date REGEXP '[0-9]+/[0-9]+/[0-9]', STR_TO_DATE(@measure_end_date, '%m/%d/%Y'), '0000-00-00')
;
-- Create Database Clone
CREATE DATABASE revforce_motosports_clone;
USE revforce_motosports_clone;

-- ======================
-- Table: teams
-- ======================
CREATE TABLE teams (
  team_id INT(11) NOT NULL AUTO_INCREMENT,
  team_name VARCHAR(100) NOT NULL UNIQUE,
  budget BIGINT(20) DEFAULT 2000000,
  origin VARCHAR(100) DEFAULT NULL,
  founding_year INT(11) DEFAULT YEAR(CURDATE()),
  email VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (team_id)
);

-- ======================
-- Table: cars
-- ======================
CREATE TABLE cars (
  car_id INT(11) NOT NULL AUTO_INCREMENT,
  car_name VARCHAR(100) NOT NULL UNIQUE,
  price BIGINT(20) NOT NULL,
  engine_power INT(11) DEFAULT NULL,
  max_speed INT(11) DEFAULT NULL,
  team_id INT(11) DEFAULT NULL,
  PRIMARY KEY (car_id),
  FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- ======================
-- Table: drivers
-- ======================
CREATE TABLE drivers (
  driver_id INT(11) NOT NULL AUTO_INCREMENT,
  driver_name VARCHAR(100) NOT NULL,
  skill_level INT(11) NOT NULL,
  joined_date DATE NOT NULL,
  rental_price BIGINT(20) NOT NULL,
  nationality VARCHAR(50) DEFAULT NULL,
  team_id INT(11) DEFAULT NULL,
  PRIMARY KEY (driver_id),
  FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- ======================
-- Table: tracks
-- ======================
CREATE TABLE tracks (
  track_id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE,
  location VARCHAR(100) DEFAULT NULL,
  length_km FLOAT DEFAULT NULL,
  track_img_url VARCHAR(1500) DEFAULT NULL,
  difficulty_level VARCHAR(50) DEFAULT NULL,
  track_type ENUM('Street','Circuit','Off-road') DEFAULT 'Circuit',
  PRIMARY KEY (track_id)
);

-- ======================
-- Table: races
-- ======================
CREATE TABLE races (
  race_id INT(11) NOT NULL AUTO_INCREMENT,
  track_id INT(11) NOT NULL,
  race_date DATE NOT NULL,
  race_time TIME NOT NULL,
  laps INT(11) NOT NULL,
  PRIMARY KEY (race_id),
  FOREIGN KEY (track_id) REFERENCES tracks(track_id)
);

-- ======================
-- Table: cancelled_races
-- ======================
CREATE TABLE cancelled_races (
  cancel_id INT(11) NOT NULL AUTO_INCREMENT,
  race_id INT(11) NOT NULL,
  track_id INT(11) NOT NULL,
  race_date DATE NOT NULL,
  race_time TIME NOT NULL,
  laps INT(11) NOT NULL,
  cancel_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (cancel_id),
  FOREIGN KEY (track_id) REFERENCES tracks(track_id)
);

-- ======================
-- Table: race_participations
-- ======================
CREATE TABLE race_participations (
  participation_id INT(11) NOT NULL AUTO_INCREMENT,
  race_id INT(11) NOT NULL,
  team_id INT(11) NOT NULL,
  car_id INT(11) DEFAULT NULL,
  driver_id INT(11) DEFAULT NULL,
  PRIMARY KEY (participation_id),
  FOREIGN KEY (race_id) REFERENCES races(race_id) ON DELETE CASCADE,
  FOREIGN KEY (team_id) REFERENCES teams(team_id) ON DELETE CASCADE,
  FOREIGN KEY (car_id) REFERENCES cars(car_id),
  FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

-- ======================
-- Table: race_results
-- ======================
CREATE TABLE race_results (
  result_id INT(11) NOT NULL AUTO_INCREMENT,
  race_id INT(11) NOT NULL,
  participation_id INT(11) NOT NULL,
  position INT(11) DEFAULT NULL,
  points INT(11) DEFAULT NULL,
  PRIMARY KEY (result_id),
  FOREIGN KEY (race_id) REFERENCES races(race_id),
  FOREIGN KEY (participation_id) REFERENCES race_participations(participation_id)
);

-- ======================
-- Table: sponsors
-- ======================
CREATE TABLE sponsors (
  sponsor_id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE,
  industry VARCHAR(100) DEFAULT NULL,
  contract_value BIGINT(20) NOT NULL,
  contract_duration_months INT(11) NOT NULL,
  PRIMARY KEY (sponsor_id)
);

-- ======================
-- Table: sponsorship_offers
-- ======================
CREATE TABLE sponsorship_offers (
  offer_id INT(11) NOT NULL AUTO_INCREMENT,
  team_id INT(11) NOT NULL,
  sponsor_name VARCHAR(100) NOT NULL,
  industry VARCHAR(100) DEFAULT NULL,
  amount BIGINT(20) NOT NULL,
  contract_duration_months INT(11) NOT NULL,
  status ENUM('pending','accepted','declined') DEFAULT 'pending',
  offer_start_date DATE NOT NULL,
  offer_expire_date DATE DEFAULT NULL,
  PRIMARY KEY (offer_id),
  FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- ======================
-- Table: users
-- ======================
CREATE TABLE users (
  user_id INT(11) NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(64) NOT NULL,
  role ENUM('admin','user') NOT NULL,
  team_id INT(11) DEFAULT NULL,
  access_key VARCHAR(50) DEFAULT NULL UNIQUE,
  PRIMARY KEY (user_id),
  FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- ======================
-- Stored Procedure: add_sponsorship_offer
-- ======================
DELIMITER $$
CREATE PROCEDURE add_sponsorship_offer (
    IN p_team_id INT,
    IN p_sponsor_name VARCHAR(100),
    IN p_industry VARCHAR(100),
    IN p_amount BIGINT,
    IN p_contract_duration_months INT
)
BEGIN
    DECLARE v_offer_start_date DATE;
    DECLARE v_offer_expire_date DATE;

    SET v_offer_start_date = CURRENT_DATE();
    SET v_offer_expire_date = DATE_ADD(v_offer_start_date, INTERVAL p_contract_duration_months MONTH);

    INSERT INTO sponsorship_offers (
        team_id,
        sponsor_name,
        industry,
        amount,
        contract_duration_months,
        status,
        offer_start_date,
        offer_expire_date
    )
    VALUES (
        p_team_id,
        p_sponsor_name,
        p_industry,
        p_amount,
        p_contract_duration_months,
        'pending',
        v_offer_start_date,
        v_offer_expire_date
    );
END$$
DELIMITER ;

-- ======================
-- Trigger: after_race_delete
-- ======================
DELIMITER $$
CREATE TRIGGER after_race_delete
AFTER DELETE ON races
FOR EACH ROW
BEGIN
    INSERT INTO cancelled_races (
        race_id,
        track_id,
        race_date,
        race_time,
        laps,
        cancel_date
    ) VALUES (
        OLD.race_id,
        OLD.track_id,
        OLD.race_date,
        OLD.race_time,
        OLD.laps,
        CURRENT_TIMESTAMP()
    );
END$$
DELIMITER ;
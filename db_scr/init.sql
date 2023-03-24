CREATE DATABASE car_renting;
use car_renting;

CREATE TABLE IF NOT EXISTS  category (
    id INT NOT NULL AUTO_INCREMENT,
    name varchar(150) NOT NULL,
    PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS  manufacturing_company (
    id INT NOT NULL AUTO_INCREMENT,
    name varchar(150) NOT NULL,
    PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS vehicle_type (
    id INT NOT NULL AUTO_INCREMENT,
    manufacturer INT  NOT NULL,
    model varchar(150) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (manufacturer) REFERENCES manufacturing_company(id)
)

CREATE TABLE IF NOT EXISTS  vehicle (
    id INT NOT NULL AUTO_INCREMENT,
    vehicle_type INT  NOT NULL,
    cat_id INT  NOT NULL,
    name varchar(150) NOT NULL,
    size TINYINT(1) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (vehicle_type) REFERENCES vehicle_type(id),
    FOREIGN KEY (cat_id) REFERENCES category(id),
    CONSTRAINT size_check_constraint CHECK (size>=1 AND size<=7)
)

CREATE TABLE IF NOT EXISTS  customer (
    id INT NOT NULL AUTO_INCREMENT,
    name varchar(150) NOT NULL,
    email varchar(68) NOT NULL UNIQUE,
    PRIMARY KEY (id),
    INDEX (email)
)

CREATE TABLE IF NOT EXISTS  booking (
    id INT NOT NULL AUTO_INCREMENT,
    vehicle_id INT  NOT NULL,
    customer_id INT  NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_available TINYINT(1) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicle(id),
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    CONSTRAINT booking_is_available_constraint CHECK (is_available=0 OR is_available=1),
    CONSTRAINT booking_start_date_constraint CHECK ( start_date >= CURRENT_DATE()),
    CONSTRAINT booking_end_date_constraint CHECK ( DATE_SUB(end_date , INTERVAL 7 DAY) <= start_date)
)

CREATE TABLE IF NOT EXISTS  payment (
    id INT NOT NULL AUTO_INCREMENT,
    booking_id INT NOT NULL,
    transaction_id varchar(150) NOT NULL,
    date_time DATETIME NOT NULL,
    status varchar(150) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (booking_id) REFERENCES booking(id)
    CONSTRAINT payment_status_constraint CHECK ( status='paid' OR status='completed' OR status = 'failed')

)

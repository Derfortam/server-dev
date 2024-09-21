create database creditBank;
use creditBank; 
CREATE TABLE clients (
    clientId INTEGER PRIMARY KEY AUTO_INCREMENT,
    fullName VARCHAR(90) NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL,
    workName VARCHAR(30) NOT NULL,
    averageSalary DECIMAL(10,2) NOT NULL,
    creditStory VARCHAR(90) NOT NULL,
    email VARCHAR(30) NOT NULL UNIQUE,
    firstCallDate DATE NOT NULL
);

CREATE TABLE staff (
    staffId INTEGER PRIMARY KEY AUTO_INCREMENT,
    surname VARCHAR(30) NOT NULL,
    nameStaff VARCHAR(30) NOT NULL,
    fatherName VARCHAR(30) NOT NULL,
    workInBank INTEGER NOT NULL,
    position VARCHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL UNIQUE,
    FOREIGN KEY (workInBank) REFERENCES bank(bankId) 
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE payment (
    paymentId INTEGER PRIMARY KEY AUTO_INCREMENT,
    clientId INTEGER NOT NULL,
    staffId INTEGER NOT NULL,
    sum DECIMAL(10,2) NOT NULL,
    dateNow DATE NOT NULL,
    typeCredit VARCHAR(50) NOT NULL,
    numOfCredit INTEGER NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (clientId) REFERENCES clients(clientId)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (staffId) REFERENCES staff(staffId)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE bank (
    bankId INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL
);

CREATE TABLE infoCredit (
    creditId INTEGER PRIMARY KEY AUTO_INCREMENT,
    clientId INTEGER NOT NULL,
    staffId INTEGER NOT NULL,
    sum DECIMAL(10,2) NOT NULL,
    dateNow DATE NOT NULL,
    typeCredit VARCHAR(50) NOT NULL,
    FOREIGN KEY (clientId) REFERENCES clients(clientId)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (staffId) REFERENCES staff(staffId)
        ON UPDATE CASCADE ON DELETE RESTRICT
);



INSERT INTO bank(bankid, name) VALUES (1, 'ПриватБанк');
INSERT INTO bank(bankid, name) VALUES (2, 'ОщадБанк');

SELECT * FROM bank;

INSERT INTO staff(surname, name, fatherName, workInBank, position, email) 
VALUES ('Яківчук', 'Денис', 'Петрович', 2, 'Менеджер', 'denisYachNew@gmail.com');

INSERT INTO staff(surname, name, fatherName, workInBank, position, email) 
VALUES ('Томляк', 'Віктор', 'Олександрович', 2, 'Менеджер', 'victorTomNew@gmail.com');
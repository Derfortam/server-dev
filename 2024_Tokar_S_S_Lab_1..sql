CREATE DATABASE banking_system;
USE banking_system;
SET NAMES utf8mb4;

-- 1. Таблиця для банків
CREATE TABLE banks (
    bankId INT PRIMARY KEY AUTO_INCREMENT,
    bankName VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phoneNumber VARCHAR(20),
    email VARCHAR(100)
);

-- 2. Таблиця для посад
CREATE TABLE positions (
    positionId INT PRIMARY KEY AUTO_INCREMENT,
    positionName VARCHAR(50) NOT NULL
);

-- 3. Таблиця для співробітників
CREATE TABLE employees (
    employeeId INT PRIMARY KEY AUTO_INCREMENT,
    lastName VARCHAR(100) NOT NULL,
    firstName VARCHAR(100) NOT NULL,
    middleName VARCHAR(100),
    bankId INT,
    positionId INT,
    email VARCHAR(100),
    FOREIGN KEY (bankId) REFERENCES banks(bankId),
    FOREIGN KEY (positionId) REFERENCES positions(positionId)
);

-- 4. Таблиця для клієнтів
CREATE TABLE clients (
    clientId INT PRIMARY KEY AUTO_INCREMENT,
    fullName VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phoneNumber VARCHAR(20),
    workPlace VARCHAR(100),
    averageSalary DECIMAL(10, 2),
    email VARCHAR(100),
    firstContactDate DATE
);

-- 5. Таблиця для типів кредитів
CREATE TABLE credit_types (
    creditTypeId INT PRIMARY KEY AUTO_INCREMENT,
    creditTypeName VARCHAR(50) NOT NULL
);

-- 6. Таблиця для кредитних договорів
CREATE TABLE credit_contracts (
    contractId INT PRIMARY KEY AUTO_INCREMENT,
    clientId INT,
    employeeId INT,
    contractNumber VARCHAR(50) NOT NULL,
    creditTypeId INT,
    creditAmount DECIMAL(12, 2),
    creditDate DATE,
    FOREIGN KEY (clientId) REFERENCES clients(clientId),
    FOREIGN KEY (employeeId) REFERENCES employees(employeeId),
    FOREIGN KEY (creditTypeId) REFERENCES credit_types(creditTypeId)
);

-- 7. Таблиця для типів операцій
CREATE TABLE operation_types (
    operationTypeId INT PRIMARY KEY AUTO_INCREMENT,
    operationName VARCHAR(50) NOT NULL
);

-- 8. Таблиця для статусів платежів
CREATE TABLE payment_status (
    statusId INT PRIMARY KEY AUTO_INCREMENT,
    statusName VARCHAR(50) NOT NULL
);

-- 9. Таблиця для платежів
CREATE TABLE payments (
    paymentId INT PRIMARY KEY AUTO_INCREMENT,
    clientId INT,
    employeeId INT,
    paymentAmount DECIMAL(12, 2),
    paymentDate DATE,
    contractId INT,
    operationTypeId INT,
    statusId INT,
    FOREIGN KEY (clientId) REFERENCES clients(clientId),
    FOREIGN KEY (employeeId) REFERENCES employees(employeeId),
    FOREIGN KEY (contractId) REFERENCES credit_contracts(contractId),
    FOREIGN KEY (operationTypeId) REFERENCES operation_types(operationTypeId),
    FOREIGN KEY (statusId) REFERENCES payment_status(statusId)
);

-- 10. Таблиця для контактної інформації клієнтів
CREATE TABLE client_contacts (
    contactId INT PRIMARY KEY AUTO_INCREMENT,
    clientId INT,
    contactType VARCHAR(50),
    contactValue VARCHAR(100),
    FOREIGN KEY (clientId) REFERENCES clients(clientId)
);

-- 11. Таблиця для додаткових інформацій про банки
CREATE TABLE bank_additional_info (
    infoId INT PRIMARY KEY AUTO_INCREMENT,
    bankId INT,
    openingHours VARCHAR(100),
    website VARCHAR(100),
    FOREIGN KEY (bankId) REFERENCES banks(bankId)
);

-- 12. Таблиця для офісів банків
CREATE TABLE bank_offices (
    officeId INT PRIMARY KEY AUTO_INCREMENT,
    bankId INT,
    officeName VARCHAR(100),
    officeAddress VARCHAR(255),
    phoneNumber VARCHAR(20),
    FOREIGN KEY (bankId) REFERENCES banks(bankId)
);

-- 13. Таблиця для типів місць роботи
CREATE TABLE work_types (
    workTypeId INT PRIMARY KEY AUTO_INCREMENT,
    workTypeName VARCHAR(50) NOT NULL
);

-- 14. Таблиця для клієнтів і типу їх роботи
CREATE TABLE client_work_types (
    clientId INT,
    workTypeId INT,
    FOREIGN KEY (clientId) REFERENCES clients(clientId),
    FOREIGN KEY (workTypeId) REFERENCES work_types(workTypeId)
);

-- 15. Таблиця для співробітників і сертифікацій
CREATE TABLE employee_certifications (
    certificationId INT PRIMARY KEY AUTO_INCREMENT,
    employeeId INT,
    certificationName VARCHAR(100),
    issueDate DATE,
    expirationDate DATE,
    FOREIGN KEY (employeeId) REFERENCES employees(employeeId)
);


-- Вставка даних для банків
INSERT INTO banks (bankName, address, phoneNumber, email) VALUES 
('ПриватБанк', 'м. Київ, вул. Хрещатик 12', '+380123456789', 'info@privatbank.ua'),
('ОщадБанк', 'м. Львів, вул. Січових Стрільців 5', '+380987654321', 'info@oschadbank.ua'),
('АльфаБанк', 'м. Одеса, вул. Дерибасівська 10', '+380112233445', 'info@alfabank.ua'),
('УкрсибБанк', 'м. Харків, вул. Сумська 18', '+380556677889', 'info@ukrsibbank.ua'),
('Райффайзен Банк', 'м. Дніпро, пр. Дмитра Яворницького 22', '+380334455667', 'info@raiffeisen.ua');

-- Вставка даних для посад
INSERT INTO positions (positionName) VALUES 
('Менеджер'),
('Консультант'),
('Кредитний аналітик'),
('Касир'),
('Фінансовий радник');

-- Вставка даних для співробітників
INSERT INTO employees (lastName, firstName, middleName, bankId, positionId, email) VALUES 
('Іваненко', 'Іван', 'Іванович', 1, 1, 'ivanenko@privatbank.ua'),
('Петренко', 'Петро', 'Петрович', 2, 2, 'petrenko@oschadbank.ua'),
('Сидоренко', 'Сидір', 'Сидорович', 3, 3, 'sydorenko@alfabank.ua'),
('Ковальчук', 'Олена', 'Олександрівна', 4, 4, 'kovalchuk@ukrsibbank.ua'),
('Гнатенко', 'Ганна', 'Іванівна', 5, 5, 'gnatenko@raiffeisen.ua');

-- Вставка даних для клієнтів
INSERT INTO clients (fullName, address, phoneNumber, workPlace, averageSalary, email, firstContactDate) VALUES 
('Василенко Василь Васильович', 'м. Київ, вул. Зелена 10', '+380111111111', 'Завод АТЗ', 15000, 'vasilenko@gmail.com', '2022-01-15'),
('Мартиненко Ольга Олексіївна', 'м. Львів, вул. Головна 3', '+380222222222', 'ТОВ "Сталь"', 18000, 'martynenko@gmail.com', '2021-10-10'),
('Дмитренко Олексій Вікторович', 'м. Одеса, вул. Морська 1', '+380333333333', 'ФОП', 12000, 'dmytrenko@gmail.com', '2023-03-20'),
('Кравчук Світлана Іванівна', 'м. Харків, вул. Пушкінська 12', '+380444444444', 'ІТ-компанія', 25000, 'kravchuk@gmail.com', '2020-07-01'),
('Шевченко Олександр Миколайович', 'м. Дніпро, вул. Січова 5', '+380555555555', 'ТОВ "Пром"', 22000, 'shevchenko@gmail.com', '2023-09-09');

-- Вставка даних для типів кредитів
INSERT INTO credit_types (creditTypeName) VALUES 
('Споживчий кредит'),
('Іпотечний кредит'),
('Автокредит'),
('Кредит на бізнес'),
('Кредитна карта');

-- Вставка даних для кредитних договорів
INSERT INTO credit_contracts (clientId, employeeId, contractNumber, creditTypeId, creditAmount, creditDate) VALUES 
(1, 1, 'CN001', 1, 100000.00, '2023-01-10'),
(2, 2, 'CN002', 2, 500000.00, '2023-03-15'),
(3, 3, 'CN003', 3, 200000.00, '2023-06-20'),
(4, 4, 'CN004', 4, 300000.00, '2023-09-01'),
(5, 5, 'CN005', 5, 150000.00, '2023-08-05');

-- Вставка даних для типів операцій
INSERT INTO operation_types (operationName) VALUES 
('Видача кредиту'),
('Повернення коштів'),
('Комісія за обслуговування'),
('Зміна умов кредиту'),
('Закриття кредиту');

-- Вставка даних для статусів платежів
INSERT INTO payment_status (statusName) VALUES 
('Успішний'),
('Неуспішний'),
('Очікує'),
('Відмінений'),
('Прострочений');

-- Вставка даних для платежів
INSERT INTO payments (clientId, employeeId, paymentAmount, paymentDate, contractId, operationTypeId, statusId) VALUES 
(1, 1, 20000.00, '2023-02-01', 1, 1, 1),
(2, 2, 10000.00, '2023-04-10', 2, 2, 1),
(3, 3, 15000.00, '2023-07-05', 3, 1, 1),
(4, 4, 25000.00, '2023-09-15', 4, 2, 1),
(5, 5, 3000.00, '2023-10-01', 5, 1, 1);

-- Вставка даних для контактної інформації клієнтів
INSERT INTO client_contacts (clientId, contactType, contactValue) VALUES 
(1, 'Телефон', '+380111111111'),
(1, 'Email', 'vasilenko@gmail.com'),
(2, 'Телефон', '+380222222222'),
(2, 'Email', 'martynenko@gmail.com'),
(3, 'Телефон', '+380333333333');

-- Вставка даних для додаткової інформації про банки
INSERT INTO bank_additional_info (bankId, openingHours, website) VALUES 
(1, 'Пн-Пт 9:00-18:00', 'https://privatbank.ua'),
(2, 'Пн-Пт 9:00-19:00', 'https://oschadbank.ua'),
(3, 'Пн-Пт 9:00-18:30', 'https://alfabank.ua'),
(4, 'Пн-Пт 9:00-18:00', 'https://ukrsibbank.ua'),
(5, 'Пн-Пт 9:00-17:30', 'https://raiffeisen.ua');

-- Вставка даних для офісів банків
INSERT INTO bank_offices (bankId, officeName, officeAddress, phoneNumber) VALUES 
(1, 'Головний офіс', 'м. Київ, вул. Хрещатик 12', '+380123456789'),
(2, 'Філія №1', 'м. Львів, вул. Січових Стрільців 5', '+380987654321'),
(3, 'Філія №2', 'м. Одеса, вул. Дерибасівська 10', '+380112233445'),
(4, 'Головний офіс', 'м. Харків, вул. Сумська 18', '+380556677889'),
(5, 'Філія №3', 'м. Дніпро, пр. Дмитра Яворницького 22', '+380334455667');

-- Вставка даних для типів місць роботи
INSERT INTO work_types (workTypeName) VALUES 
('Державна служба'),
('Приватний сектор'),
('Фриланс'),
('Підприємець'),
('Студент');

-- Вставка даних для клієнтів і типу їх роботи
INSERT INTO client_work_types (clientId, workTypeId) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

SELECT * from employee_certifications;
-- Вставка даних для співробітників і сертифікацій
INSERT INTO employee_certifications (employeeId, certificationName, issueDate, expirationDate) VALUES 
(1, 'Сертифікат менеджера', '2023-01-01', '2025-01-01'),
(2, 'Сертифікат консультанта', '2022-05-15', '2024-05-15'),
(3, 'Сертифікат кредитного аналітика', '2023-06-20', '2025-06-20'),
(4, 'Сертифікат касира', '2023-02-10', '2025-02-10'),
(5, 'Сертифікат фінансового радника', '2022-08-08', '2024-08-08');


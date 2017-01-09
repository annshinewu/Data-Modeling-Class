DROP DATABASE IF EXISTS TheWorldOfTomorrow;
CREATE DATABASE TheWorldOfTomorrow;
USE TheWorldOfTomorrow;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

/*
1. A database with at least 5 entities, 5 relationships,
2. At least 20 attributes,
3. 10 customers,
4. 20 orders of the good/service,
5. 10 employees, with salaries. You are the CEO with the highest salary.
6. Normalization test
7. 5 simple queries (SELECT, LIMIT, UNION)
8. 5 complex queries (GROUP BY, JOIN)
*/
CREATE TABLE Government(
  country_name VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (country_name)
);

CREATE TABLE DepartmentOfAirTraffic(
  department_id INT NOT NULL UNIQUE,
  country_name VARCHAR(50) NOT NULL,
  department_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (department_id),
  FOREIGN KEY (country_name) REFERENCES government(country_name)
);

CREATE TABLE FlyingLicense(
  license_id INT NOT NULL UNIQUE,
  customer_id INT,
  PRIMARY KEY(license_id),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE ReceiveFrom(
  transfer_id INT NOT NULL UNIQUE,
  country_name VARCHAR(50) NOT NULL,
  FOREIGN KEY(transfer_id) REFERENCES Funds(transfer_id),
  FOREIGN KEY (country_name) REFERENCES government(country_name)
);

CREATE TABLE Funds(
  transfer_id INT NOT NULL UNIQUE,
  date DATE NOT NULL,
  amount INT NOT NULL,
  PRIMARY KEY(transfer_id)
);

CREATE TABLE Establish(
  department_id INT NOT NULL,
  rule_id INT NOT NULL,
  FOREIGN KEY(department_id) REFERENCES DepartmentOfAirTraffic(department_id),
  FOREIGN KEY(rule_id) REFERENCES TrafficRules(rule_id)
);

CREATE TABLE TrafficRules(
  rule_id INT NOT NULL UNIQUE,
  information VARCHAR(100) NOT NULL,
  established_date DATE NOT NULL,
  PRIMARY KEY(rule_id)
);

CREATE TABLE ThroughTheVotingOf(
  country_name VARCHAR(50) NOT NULL,
  rule_id INT NOT NULL,
  FOREIGN KEY (country_name) REFERENCES government(country_name),
  FOREIGN KEY(rule_id) REFERENCES TrafficRules(rule_id)
);

CREATE TABLE Hire(
  department_id INT NOT NULL,
  employee_id INT NOT NULL UNIQUE,
  FOREIGN KEY(department_id) REFERENCES DepartmentOfAirTraffic(department_id),
  FOREIGN KEY(employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Employees(
  employee_id INT NOT NULL UNIQUE,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  position VARCHAR (50) NOT NULL,
  salary INT NOT NULL,
  PRIMARY KEY (employee_id)
);

CREATE TABLE ToAdminister(
  test_id INT NOT NULL UNIQUE,
  employee_id INT NOT NULL,
  FOREIGN KEY(test_id) REFERENCES FlyingTest(test_id),
  FOREIGN KEY(employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE FlyingTest(
  test_id INT NOT NULL UNIQUE,
  employee_id INT NOT NULL,
  customer_id INT NOT NULL,
  results VARCHAR(50) NOT NULL,
  date DATE NOT NULL,
  PRIMARY KEY (test_id),
  FOREIGN KEY(employee_id) REFERENCES Employees(employee_id),
  FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE AdministerFor(
  test_id INT NOT NULL UNIQUE,
  customer_id INT NOT NULL,
  FOREIGN KEY(test_id) REFERENCES FlyingTest(test_id),
  FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Customers(
  customer_id INT NOT NULL UNIQUE,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (customer_id)
);

CREATE TABLE Receive(
  department_id INT NOT NULL,
  transfer_id INT NOT NULL UNIQUE,
  FOREIGN KEY(department_id) REFERENCES DepartmentOfAirTraffic(department_id),
  FOREIGN KEY(transfer_id) REFERENCES Funds(transfer_id)
);

CREATE TABLE RegisterToReceive (
  customer_id INT NOT NULL,
  license_id INT NOT NULL UNIQUE,
  FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
  FOREIGN KEY(license_id) REFERENCES FlyingLicense(license_id)
);

CREATE TABLE Buys(
  department_id INT NOT NULL,
  license_id INT NOT NULL,
  transaction_id INT NOT NULL UNIQUE,
  amount INT NOT NULL,
  PRIMARY KEY(transaction_id),
  FOREIGN KEY(department_id) REFERENCES DepartmentOfAirTraffic(department_id),
  FOREIGN KEY(license_id) REFERENCES FlyingLicense(license_id)
);

CREATE TABLE Sells(
  department_id INT NOT NULL,
  license_id INT NOT NULL,
  transaction_id INT NOT NULL UNIQUE,
  amount INT NOT NULL,
  PRIMARY KEY(transaction_id),
  FOREIGN KEY(department_id) REFERENCES DepartmentOfAirTraffic(department_id),
  FOREIGN KEY(license_id) REFERENCES FlyingLicense(license_id)
);

INSERT INTO Customers (customer_id, first_name, last_name) VALUES (1, 'Michelle', 'Perng');
INSERT INTO Customers VALUES(2, 'Grace', 'Wu');
INSERT INTO Customers VALUES(3, 'Jessica', 'Wu');
INSERT INTO Customers VALUES(4, 'Angela', 'Chen');
INSERT INTO Customers VALUES(5, 'Amy', 'Wen');
INSERT INTO Customers VALUES(6, 'May', 'Lee');
INSERT INTO Customers VALUES(7, 'Ryan', 'Chae');
INSERT INTO Customers VALUES(8, 'Christina', 'Wang');
INSERT INTO Customers VALUES(9, 'Einar', 'K');
INSERT INTO Customers VALUES(10, 'Wesley', 'Luh');

INSERT INTO FlyingLicense (license_id, customer_id) VALUES (1, 1);
INSERT INTO FlyingLicense VALUES (2, NULL);
INSERT INTO FlyingLicense VALUES (3, NULL);
INSERT INTO FlyingLicense VALUES (4, NULL);
INSERT INTO FlyingLicense VALUES (5, NULL);
INSERT INTO FlyingLicense VALUES (6, NULL);
INSERT INTO FlyingLicense VALUES (7, NULL);
INSERT INTO FlyingLicense VALUES (8, NULL);
INSERT INTO FlyingLicense VALUES (9, NULL);
INSERT INTO FlyingLicense VALUES (10, NULL);

INSERT INTO RegisterToReceive (customer_id, license_id) VALUES (1, 1);
INSERT INTO RegisterToReceive VALUES (2, 4);
INSERT INTO RegisterToReceive VALUES (3, 7);
INSERT INTO RegisterToReceive VALUES (4, 8);
INSERT INTO RegisterToReceive VALUES (5, 6);
INSERT INTO RegisterToReceive VALUES (6, 2);
INSERT INTO RegisterToReceive VALUES (7, 3);
INSERT INTO RegisterToReceive VALUES (8, 9);
INSERT INTO RegisterToReceive VALUES (9, 10);
INSERT INTO RegisterToReceive VALUES (10, 5);
INSERT INTO RegisterToReceive VALUES (11, 11);
INSERT INTO RegisterToReceive VALUES (12, 14);
INSERT INTO RegisterToReceive VALUES (13, 13);
INSERT INTO RegisterToReceive VALUES (14, 17);
INSERT INTO RegisterToReceive VALUES (15, 15);
INSERT INTO RegisterToReceive VALUES (16, 20);
INSERT INTO RegisterToReceive VALUES (17, 16);
INSERT INTO RegisterToReceive VALUES (18, 19);
INSERT INTO RegisterToReceive VALUES (19, 18);
INSERT INTO RegisterToReceive VALUES (20, 12);

INSERT INTO Employees (employee_id, first_name, last_name, position, salary) VALUES (1, 'Annshine', 'Wu', 'CEO/Director', 100000);
INSERT INTO Employees VALUES (2, 'Alphege', 'Ellanher', 'General Manager', 10000);
INSERT INTO Employees VALUES (3, 'Cyrus', 'Blythe', 'Receptionist', 200);
INSERT INTO Employees VALUES (4, 'Robert', 'Del Rey', 'General Manager', 20000);
INSERT INTO Employees VALUES (5, 'Jenny', 'Lorrance', 'Driving Examiner', 500);
INSERT INTO Employees VALUES (6, 'Jennifer', 'Baker', 'Driving Examiner', 500);
INSERT INTO Employees VALUES (7, 'Erica', 'Asher' , 'Driving Examiner', 500);
INSERT INTO Employees VALUES (8, 'Linda', 'Collins', 'Driving Examiner', 500);
INSERT INTO Employees VALUES (9, 'Evan', 'Rodes', 'Consultant', 10000);
INSERT INTO Employees VALUES (10, 'Selena', 'Swift', 'Trading Manager', 30000);

INSERT INTO FlyingTest (test_id, employee_id, customer_id, results, date) VALUES (1, 2, 1, 'Fail', 20060201);
INSERT INTO FlyingTest VALUES (2, 2, 1, 'Fail', 20070305);
INSERT INTO FlyingTest VALUES (3, 2, 1, 'Pass', 20080908);
INSERT INTO FlyingTest VALUES (4, 3, 2, 'Fail', 20090903);
INSERT INTO FlyingTest VALUES (5, 4, 2, 'Fail', 20141212);
INSERT INTO FlyingTest VALUES (6, 2, 4, 'Pass', 20151214);
INSERT INTO FlyingTest VALUES (7, 5, 5, 'Fail', 20161010);
INSERT INTO FlyingTest VALUES (8, 6, 5, 'Fail', 20161225);
INSERT INTO FlyingTest VALUES (9, 9, 5, 'Fail', 20161230);
INSERT INTO FlyingTest VALUES (10, 10, 5, 'Pass', 20170101);

INSERT INTO DepartmentOfAirTraffic (department_id, country_name, department_name) VALUES (1, 'Taiwan', 'Department of Air Traffic');
INSERT INTO DepartmentOfAirTraffic VALUES (5, 'United States', 'Department of Air Traffic');
INSERT INTO DepartmentOfAirTraffic VALUES (3, 'Korea', 'Department of Air Traffic');
INSERT INTO DepartmentOfAirTraffic VALUES (2, 'Thailand', 'Department of Air Traffic');
INSERT INTO DepartmentOfAirTraffic VALUES (10, 'Japan', 'Department of Air Traffic');

INSERT INTO Funds (transfer_id, date, amount) VALUES (1, 20000305, 100);
INSERT INTO Funds VALUES (2, 20030405, 150);
INSERT INTO Funds VALUES (3, 20030509, 150);
INSERT INTO Funds VALUES (4, 20060909, 150);
INSERT INTO Funds VALUES (5, 20100312, 150);

INSERT INTO TrafficRules (rule_id, information, established_date)  VALUES (1, 'Cars & airplanes cannot cross when the light is red', 20000101);
INSERT INTO TrafficRules VALUES (2, 'Cars can only cross when the light is purple', 20031001);
INSERT INTO TrafficRules VALUES (3, 'Airplanes cannot cross when the light is purple', 20040305);
INSERT INTO TrafficRules VALUES (4, 'Airples can only cross when the light is orange', 20040209);
INSERT INTO TrafficRules VALUES (5, 'Both cars and airplanes can cross when the light is black', 20101103);

INSERT INTO Government (country_name) VALUES ('Taiwan');
INSERT INTO Government VALUES ('United States');
INSERT INTO Government VALUES ('Korea');
INSERT INTO Government VALUES ('Thailand');
INSERT INTO Government VALUES ('Japan');

INSERT INTO Buys (department_id, license_id, transaction_id, amount) VALUES (1, 1, 1, 100);
INSERT INTO Buys VALUES (1, 2, 2, 120);
INSERT INTO Buys VALUES (1, 3, 3, 200);
INSERT INTO Buys VALUES (1, 4, 4, 400);
INSERT INTO Buys VALUES (1, 5, 5, 50);

INSERT INTO Sells (department_id, license_id, transaction_id, amount) VALUES (1, 1, 1, 100);
INSERT INTO Sells VALUES (1, 2, 2, 120);
INSERT INTO Sells VALUES (1, 3, 3, 200);
INSERT INTO Sells VALUES (1, 4, 4, 400);
INSERT INTO Sells VALUES (1, 5, 5, 50);

/* Fill up:
ToAdminister
Receive
Establish
ThroughTheVotingOf
AdministerFor
Hire
ReceiveFrom
 */

INSERT INTO ToAdminister (test_id, employee_id) VALUES (1, 2);
INSERT INTO ToAdminister VALUES (2, 2);
INSERT INTO ToAdminister VALUES (3, 2);
INSERT INTO ToAdminister VALUES (4, 3);
INSERT INTO ToAdminister VALUES (5, 4);
INSERT INTO ToAdminister VALUES (6, 2);
INSERT INTO ToAdminister VALUES (7, 5);
INSERT INTO ToAdminister VALUES (8, 6);
INSERT INTO ToAdminister VALUES (9, 9);
INSERT INTO ToAdminister VALUES (10, 10);

INSERT INTO Receive (department_id, transfer_id) VALUES (1, 1);
INSERT INTO Receive VALUES (1, 2);
INSERT INTO Receive VALUES (1, 3);
INSERT INTO Receive VALUES (1, 4);
INSERT INTO Receive VALUES (1, 5);

INSERT INTO Establish (department_id, rule_id) VALUES (1, 1);
INSERT INTO Establish VALUES (1, 2);
INSERT INTO Establish VALUES (1, 3);
INSERT INTO Establish VALUES (1, 4);
INSERT INTO Establish VALUES (1, 5);

INSERT INTO ThroughTheVotingOf (country_name, rule_id) VALUES ('Taiwan', 1);
INSERT INTO ThroughTheVotingOf VALUES ('Taiwan', 2);
INSERT INTO ThroughTheVotingOf VALUES ('Taiwan', 3);
INSERT INTO ThroughTheVotingOf VALUES ('Taiwan', 4);
INSERT INTO ThroughTheVotingOf VALUES ('Taiwan', 5);

INSERT INTO AdministerFor (test_id, customer_id) VALUES (1, 1);
INSERT INTO AdministerFor VALUES (2, 1);
INSERT INTO AdministerFor VALUES (3, 1);
INSERT INTO AdministerFor VALUES (4, 2);
INSERT INTO AdministerFor VALUES (5, 2);
INSERT INTO AdministerFor VALUES (6, 4);
INSERT INTO AdministerFor VALUES (7, 5);
INSERT INTO AdministerFor VALUES (8, 5);
INSERT INTO AdministerFor VALUES (9, 5);
INSERT INTO AdministerFor VALUES (10, 5);

INSERT INTO Hire (department_id, employee_id) VALUES (1, 1);
INSERT INTO Hire VALUES (1, 2);
INSERT INTO Hire VALUES (1, 3);
INSERT INTO Hire VALUES (1, 4);
INSERT INTO Hire VALUES (1, 5);
INSERT INTO Hire VALUES (1, 6);
INSERT INTO Hire VALUES (1, 7);
INSERT INTO Hire VALUES (1, 8);
INSERT INTO Hire VALUES (1, 9);
INSERT INTO Hire VALUES (1, 10);

INSERT INTO ReceiveFrom (transfer_id, country_name) VALUES (1, 'Taiwan');
INSERT INTO ReceiveFrom VALUES (2, 'Taiwan');
INSERT INTO ReceiveFrom VALUES (3, 'Taiwan');
INSERT INTO ReceiveFrom VALUES (4, 'Taiwan');
INSERT INTO ReceiveFrom VALUES (5, 'Taiwan');

/* 5 simple queries
Find the employee ID of “Erica Asher”
Find the highest salary
Find the position with the lowest salary
Find the customer id of “Grace Wu”
Find the name of the customer with the id of 3
 */

SELECT employee_id FROM employees WHERE first_name = 'Erica' AND last_name = 'Asher';
SELECT salary FROM employees ORDER BY salary DESC LIMIT 1;
SELECT position FROM employees ORDER BY salary LIMIT 1;
SELECT customer_id FROM customers WHERE first_name = 'Grace' AND last_name = 'Wu';
SELECT first_name, last_name FROM customers WHERE customer_id = 3;

SELECT employee_id, first_name, last_name FROM employees WHERE first_name = 'Erica' AND last_name = 'Asher';
SELECT salary, position FROM employees ORDER BY salary DESC;
SELECT position, salary FROM employees ORDER BY salary;
SELECT first_name, last_name, customer_id FROM customers WHERE first_name = 'Grace' AND last_name = 'Wu';
SELECT customer_id, first_name, last_name FROM customers WHERE customer_id = 3;

/* 5 complex queries
Find the employee name who has administered the most flying tests
Find the customer name of flying test 3
Find the position and salary of the employee administering flying test 5
Find the customer who has taken the most flying tests and failed
Find the employee who administered the second flying test for Amy Wen
 */

SELECT COUNT(*), Employees.first_name, Employees.last_name FROM FlyingTest INNER JOIN Employees USING (employee_id) GROUP BY employee_id;
SELECT first_name, last_name FROM FlyingTest INNER JOIN Customers USING(customer_id) WHERE test_id = 3;
SELECT position, salary FROM FlyingTest INNER JOIN Employees USING(employee_id) WHERE test_id = 5;
SELECT COUNT(*), Customers.first_name, Customers.last_name FROM FlyingTest INNER JOIN Customers USING (customer_id) WHERE results = 'Fail' GROUP BY customer_id ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Employees.first_name, Employees.last_name, date FROM FlyingTest INNER JOIN Customers USING (customer_id)
  INNER JOIN Employees USING (employee_id) WHERE Customers.first_name = 'Amy' AND Customers.last_name = 'Wen' ORDER BY date;

SELECT COUNT(*), Employees.first_name, Employees.last_name FROM FlyingTest INNER JOIN Employees USING (employee_id) GROUP BY employee_id;
SELECT first_name, last_name FROM FlyingTest INNER JOIN Customers USING(customer_id) WHERE test_id = 3;
SELECT position, salary, test_id FROM FlyingTest INNER JOIN Employees USING(employee_id) WHERE test_id = 5;
SELECT COUNT(*), Customers.first_name, Customers.last_name FROM FlyingTest INNER JOIN Customers USING (customer_id) WHERE results = 'Fail' GROUP BY customer_id ORDER BY COUNT(*) DESC;
SELECT Employees.first_name, Employees.last_name, date FROM FlyingTest INNER JOIN Customers USING (customer_id)
  INNER JOIN Employees USING (employee_id) WHERE Customers.first_name = 'Amy' AND Customers.last_name = 'Wen' ORDER BY date;

SHOW TABLES;
DESCRIBE AdministerFor;
SELECT * FROM AdministerFor;
DESCRIBE Buys;
SELECT * FROM Buys;
DESCRIBE Customers;
SELECT * FROM Customers;
DESCRIBE DepartmentOfAirTraffic;
SELECT * FROM DepartmentOfAirTraffic;
DESCRIBE Employees;
SELECT * FROM Employees;
DESCRIBE Establish;
SELECT * FROM Establish;
DESCRIBE FlyingLicense;
SELECT * FROM FlyingLicense;
DESCRIBE FlyingTest;
SELECT * FROM FlyingTest;
DESCRIBE Funds;
SELECT * FROM Funds;
DESCRIBE Government;
SELECT * FROM Government;
DESCRIBE Hire;
SELECT * FROM Hire;
DESCRIBE Receive;
SELECT * FROM Receive;
DESCRIBE ReceiveFrom;
SELECT * FROM ReceiveFrom;
DESCRIBE RegisterToReceive;
SELECT * FROM RegisterToReceive;
DESCRIBE Sells;
SELECT * FROM Sells;
DESCRIBE ThroughTheVotingOf;
SELECT * FROM ThroughTheVotingOf;
DESCRIBE ToAdminister;
SELECT * FROM ToAdminister;
DESCRIBE TrafficRules;
SELECT * FROM TrafficRules;
-- CREATE DATABASE (MANY TABLES)
-- Can't set the foreign key for the first table below because another table hasn't been generated yet.
CREATE TABLE `employee`(
`emp_id` INT PRIMARY KEY,
`name` VARCHAR(20),
`birth_date` DATE,
`sex` VARCHAR(1),
`salary` INT,
`branch_id` INT,
`sup_id` INT
);

-- ON DELETE SET NULL 
-- If `emp_id` is deleted, `manager_id` will be set to NULL
-- primary key can't be set to NULL
CREATE TABLE `branch`(
`branch_id` INT PRIMARY KEY,
`branch_name` VARCHAR(20),
`manager_id` INT,
FOREIGN KEY (`manager_id`) REFERENCES `employee`(`emp_id`) ON DELETE SET NULL 
);

-- set foreign key
ALTER TABLE `employee`
ADD FOREIGN KEY(`branch_id`)
REFERENCES `branch`(`branch_id`) 
ON DELETE SET NULL;

ALTER TABLE `employee`
ADD FOREIGN KEY(`sup_id`)
REFERENCES `employee`(`emp_id`)
ON DELETE SET NULL;


CREATE TABLE `client`(
`client_id` INT PRIMARY KEY,
`client_name` VARCHAR(20),
`phone` VARCHAR(20)
);

CREATE TABLE `works_with`(
`emp_id` INT,
`client_id` INT,
`total_sales` INT,
PRIMARY KEY (`emp_id`, `client_id`),  -- have two PRIMARY KEY
FOREIGN KEY (`emp_id`) REFERENCES `employee`(`emp_id`) ON DELETE CASCADE, -- These two primary keys are also foreign keys
FOREIGN KEY (`client_id`) REFERENCES `client`(`client_id`) ON DELETE CASCADE
);

-- Notice the order
-- If TABLE_B also has a foreign key corresponding to the primary key of TABLE_A, it has to be written as NULL first.
INSERT INTO `branch` VALUES(1, "RD", NULL);
INSERT INTO `branch` VALUES(2, "AD", NULL);
INSERT INTO `branch` VALUES(3, "IT", NULL);

INSERT INTO `employee` VALUES(206, "Wang", "1998-10-08", "F", 50000, 1, NULL);
INSERT INTO `employee` VALUES(207, "Green", "1985-09-16", "M", 29000, 2, 206);
INSERT INTO `employee` VALUES(208, "Ken", "2000-12-19", "M", 35000, 3, 206);
INSERT INTO `employee` VALUES(209, "Lam", "1997-01-22", "F", 39000, 3, 207);
INSERT INTO `employee` VALUES(210, "Blue", "1925-11-10", "F", 84000, 1, 207);

UPDATE `branch`
SET `manager_id` = 208
WHERE `branch_id` = 3; 

-- Complete the data information
INSERT INTO `client` VALUES(400, "Eric", "1234566425");
INSERT INTO `works_with` VALUES(206, 400, "70000");

-- See all TABLES status
SELECT * FROM `branch`;  
SELECT * FROM `employee`;  
SELECT * FROM `client`;
SELECT * FROM `works_with`;


-- aggregate functions

-- get the number of employees
SELECT COUNT(*) FROM `employee`;
-- get the number of sup_id column of the employee table
SELECT COUNT(`sup_id`) FROM `employee`;
-- get female employees born after 1970-01-01
SELECT COUNT(*) FROM `employee` WHERE `birth_date` > "1970-01-01" AND `sex` = "F";

-- Get the average salary of all employees
SELECT AVG(`salary`) FROM `employee`;
-- Get the sum salary of all employees
SELECT SUM(`salary`) FROM `employee`;
-- Get the highest salary of all employees
SELECT MAX(`salary`) FROM `employee`;


-- wildcards (%: multiple characters, _: one character)

-- get the client whose phone numbers ending in 425
SELECT * FROM `client` WHERE `phone` LIKE "%425";
-- get the client with "V" in the name
SELECT * FROM `client` WHERE `client_name` LIKE "V%";
-- Get the client whose birthdays are in December
SELECT * FROM `employee` WHERE `birth_date` LIKE "_____12%"; 


-- union 

-- `client_name` union `name` (data types and the number of attributes must be the same)
SELECT `client_name` FROM `client` UNION SELECT `name` FROM `employee`; 

SELECT `client_name`, `client_id` FROM `client` UNION SELECT `name`,`emp_id` FROM `employee`; 
-- rename the column
SELECT `client_name` AS `total_name`, `client_id` AS `total_id` FROM `client` 
UNION SELECT `name`,`emp_id` FROM `employee`; 

SELECT `salary` FROM `employee` UNION SELECT `total_sales` FROM `works_with`; 


-- join
INSERT INTO `branch` VALUES(4, "lazy", NULL);  -- add a information in branch table
SELECT * FROM `branch`; 

-- get all department manager names (branch: department information, employee: manager names)
SELECT `employee`.`emp_id`, `employee`.`name`, `branch`.`branch_name`
FROM `employee` JOIN `branch`
ON `employee`.`emp_id` = `branch`.`manager_id`; -- condition

SELECT `employee`.`emp_id`, `employee`.`name`, `branch`.`branch_name`
FROM `employee` LEFT JOIN `branch`   -- regardless of whether the left table matches the condition, all data will be displayed
ON `employee`.`emp_id` = `branch`.`manager_id`;


-- subquery 

-- Find the RD manager's name
SELECT `name`
FROM `employee`
WHERE `emp_id` = (
	SELECT `manager_id`
	FROM `branch`
	WHERE `branch_name` = "RD"
); 

-- find the names of employees who have `total_sales` > 50000
SELECT `name`
FROM `employee`
WHERE `emp_id` IN(    -- IN: more than one result
	SELECT `emp_id`
	FROM `works_with`
	WHERE `total_sales` > 50000
); 
SELECT * FROM `employee`;  
SELECT * FROM `works_with`;


-- on delete (Dealing with situations where data has been deleted)
DELETE FROM `employee`  -- delete a piece of information first
WHERE `emp_id` = 207;

SELECT * FROM `branch`;  -- 207→NULL
SELECT * FROM `works_with`;  -- only 4 records left
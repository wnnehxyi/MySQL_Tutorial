CREATE DATABASE `sql_1`;  
SHOW DATABASES;         

USE `sql_1`;            # in `sql_1` database and create tables

# create table (have constraints)
CREATE TABLE `student`(
`student_id` INT PRIMARY KEY,
`name` VARCHAR(10) NOT NULL,  
`major` VARCHAR(10) DEFAULT "history" 
);

# auto increment (need to defined primary key)
CREATE TABLE `student`(
`student_id` INT AUTO_INCREMENT, 
`name` VARCHAR(10), 
`major` VARCHAR(10)  DEFAULT "history",    
PRIMARY KEY(`student_id`)  
);

# enter values
INSERT INTO `student` VALUES(1, "Jim");  # the order according to the table
INSERT INTO `student` VALUES(3, "John", NULL);  # NULL
INSERT INTO `student`(`name`, `major`, `student_id`) VALUES("Lam", "English", 4);  # define your own table

SELECT * FROM `student`;  # show table data
 
DESCRIBE `student`;    # show table
DROP TABLE `student`;  # delete table

ALTER TABLE `student` ADD gpa DECIMAL(3,2); # add attribute `gpa`, three digits and two decimal places
ALTER TABLE `student` DROP COLUMN gpa;  # delete attribute
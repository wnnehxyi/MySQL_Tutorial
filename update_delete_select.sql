-- update & delete & select data
SET SQL_SAFE_UPDATES = 0;  -- disable the safe update mode 

CREATE TABLE `student`(
`student_id` INT PRIMARY KEY,
`name` VARCHAR(10),
`major` VARCHAR(10),
`score` INT
);
INSERT INTO `student` VALUES(1, "Lam", "English", 50); 

UPDATE `student` -- update the table
SET `score` = 20  -- replace with it
WHERE `score` = 60; -- conditional

DELETE FROM `student`;  -- Delete all data in the form

-- SELECT
INSERT INTO `student`(`name`,`major`,`score`) VALUES("Lam", "English",50);

SELECT * FROM `student`;  -- *: select all attributes
SELECT `name` FROM `student`; -- only select `name` attribute
SELECT `name`, `major` FROM `student`;
SELECT *FROM `student` ORDER BY `score`;  -- ASC
SELECT *FROM `student` ORDER BY `score` DESC;  -- DESC
SELECT *FROM `student` ORDER BY `score`, `student_id`; -- sort by `score` first and then by id

SELECT * FROM `student` LIMIT 3; -- only show the first three data  
SELECT * FROM `student` WHERE `major` = "English";  -- Only return the data which major is English
SELECT * FROM `student` WHERE `major` = "English" OR `score` > 20; -- more than one condition
SELECT * FROM `student` WHERE `major` IN("English", "History"); -- return the data which major is English or history
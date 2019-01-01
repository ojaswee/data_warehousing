-- Cancel the query using your line kill character or the \c sequence
SELECT *  FROM negativePossitive  ORDER BY\c

-- You'd like to turn a query result into HTML.
--Solution: The -H and --html options produce output
mysql -H -e "SELECT * FROM tablename WHERE condition=0" databasename;

-- Connect php to mysql
if (!($conn_id = @mysql_connect ("localhost", "mysql_user", "mysql_password")))
die ("Cannot connect to server\n");
print ("Connected\n");
if (!@mysql_select_db ("db_name", $conn_id))
die ("Cannot select database\n");
mysql_close ($conn_id);
print ("Disconnected\n");

-- SELECT query and save the result set into another table, but that table
-- doesn't exist yet
CREATE TABLE destination SELECT * FROM original;

-- SELECT query and save the result set into another table,
-- if destination able already exist
INSERT INTO destination (column1,column3,column4) SELECT  column1,column3,column4
 FROM original;

-- change name of column from class to target
ALTER TABLE `dst_tbl` CHANGE COLUMN `class` `target` VARCHAR(15) NOT NULL;

-- You want to pull a section of rows out of the middle of the set,
-- such as rows 21 through 40.

-- return skip 2 rows then return only 1rd row
-- I want only 3rd row
SELECT * FROM profile ORDER BY birth LIMIT 2,1;

--transfer all information from one table to another and delete the original table
-- to do this we need to either lock both tables when transfer is happening or
-- use insert into destination table and delete from original table in same statement
--as below
SET @cutoff = CURDATE( );
INSERT INTO repolog SELECT * FROM worklog WHERE t < @cutoff;
DELETE FROM worklog WHERE t < @cutoff;

--need table for short time and want it to disappear automatically
--for temp table it doesnot matter if name exits already beacuse
--temporary table "hides" the permanent table for the duration of its
--existence, which can be useful for making a copy of a table that you can modify

CREATE TEMPORARY TABLE temp_table SELECT * FROM original;


--working with strings

/*
Table used in this example
+----------+--------+------+------+------+
| instance | target | a1   | a2   | a3   |
+----------+--------+------+------+------+
|        1 | -      | T    | T    | F    |
|        2 | -      | F    | T    | F    |
|        3 | +      | F    | T    | T    |
|        4 | -      | F    | F    | T    |
|        5 | -      | T    | F    | F    |
|        6 | +      | F    | F    | F    |
+----------+--------+------+------+------+
*/

-- null is treated as spearate target use not null, is null to handle nulls
delete from dst_tbl where target is NULL;

-- Checking Whether a String Contains a Substring
SELECT target, LOCATE('ss',target), LOCATE('ss',target,1) FROM negativePossitive;

SELECT target FROM negativePossitive WHERE target LIKE '%ss%';

-- REGEXP is better then like and locate coz it can do many other things
SELECT target FROM negativePossitive WHERE target REGEXP 'ss';

-- match meta characters with backslash
SELECT target, target REGEXP '\\.', target REGEXP '\\^', target REGEXP '\\$'
FROM negativePossitive;

--match blackslash
SELECT target, target LIKE '\\', target REGEXP '\' FROM metachar;

'
-- to make match case sensitive use convert it to binary then match
SELECT a1, a1 = BINARY 'T', BINARY a1 = 't' FROM negativePossitive;

--find how many occurance of a word is in a column of a table
--to do this we need to first prepare it for use in FULLTEXT searching by
-- adding a FULLTEXT index
ALTER TABLE negativePossitive ADD FULLTEXT (a1);

-- not working beacuse One property of the indexing engine is that it ignores
-- words that are "too common" (that is,words that occur in more than half the records).
-- also indexing engine doesn't include words less than four characters long.
SELECT COUNT(*) from negativePossitive WHERE MATCH(a1) AGAINST('T');

ALTER TABLE negativePossitive MODIFY COLUMN a1 VARCHAR(10);

UPDATE negativePossitive
SET a1 = 'False'
WHERE a1 like ('F');

--after I made this modification it worked
SELECT COUNT(*) from negativePossitive WHERE MATCH(a1) AGAINST('True');
/*
+----------+
| COUNT(*) |
+----------+
|        2 |
+----------+
*/


-- working with data and time
use test;
DROP TABLE IF EXISTS cpi;
CREATE TABLE cpi (
  country VARCHAR (50),
  lifeExp float,
  income float,
  mortality float,
  spending float,
  school float,
  result float,
  cpi_date date,
  cpi_time time
);

LOAD DATA LOCAL INFILE '/home/ojaswee/cs_topics/MySQL/CPI_dataset_ojaswee.csv'
INTO TABLE cpi
fields terminated BY ","
lines terminated BY "\n"
IGNORE 1 LINES;

ALTER TABLE cpi ADD id INT PRIMARY KEY AUTO_INCREMENT FIRST;

select * from cpi;

-- change format of cpi_date
SELECT cpi_date, DATE_FORMAT(cpi_date,'%M %d, %Y') FROM cpi;

-- count number of days between now and cpi_date
SELECT cpi_date,DATEDIFF(NOW(),cpi_date) FROM cpi;

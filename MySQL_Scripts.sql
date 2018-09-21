"/*!data was extracted from 
 */
/* ! create a new database*/
CREATE database cancer_muts; 
LOAD DATA INFILE 'data.txt' INTO TABLE db2.my_table;


CREATE TABLE cosmic(
  chromosome VARCHAR(3) NOT NULL,
  position INT NOT NULL,
  ID VARCHAR(45) NOT NULL,
  refe VARCHAR(45) NULL,
  alt VARCHAR(45) NULL,
  qual VARCHAR(45) NULL,
  filter VARCHAR(45) NULL,
  info VARCHAR(10000) NULL, -- this is the max value we can input
  PRIMARY KEY (ID)
);


--to load data in MySql
bash load_data.sh


insert into cosmic3 select * from cosmic;


-- extract only 100000 rows
head -n 100000 CosmicCodingMuts.csv >  cosmic100.csv

--how many mutations exist in chromosom 2 between position 45595 and 45601
select count(*) from cosmic where chromosome='2' and position >= 35406  and position <= 45601;



--create index
CREATE index chrom ON cosmic5 (chromosome);
CREATE index position ON cosmic5 (position);
CREATE index refe ON cosmic5 (refe);
CREATE index alt ON cosmic5 (alt);



-- observe the time to execute we use query profiling using performance schema
-- https://dev.mysql.com/doc/refman/5.6/en/performance-schema-query-profiling.html
--since we have older version of mysql in linix computer we use profiles comand as follows

set profiling=1;


RESET QUERY CACHE;
select count(*) from cosmic2 where chromosome='1' and position >= 35416 and refe = 'A';

 show profiles; 

--drop database cancer_muts;



select * from cosmic where chromosome=20 and position=96030 and refe='G' and alt='A';




|        6 | 3.80685625 | select * from cosmic where chromosome=20 and position=96030 and refe='G' and alt='A'   |
|        7 | 0.00026350 | RESET QUERY CACHE                                                                      |
|        8 | 2.15368175 | select * from cosmic2 where chromosome=20 and position=96030 and refe='G' and alt='A'  |
|        9 | 0.00016600 | RESET QUERY CACHE                                                                      |
|       10 | 0.00974850 | select * from cosmic3  where chromosome=20 and position=96030 and refe='G' and alt='A' |
|       11 | 0.00021350 | RESET QUERY CACHE                                                                      |
|       12 | 0.00707575 | select * from cosmic4  where chromosome=20 and position=96030 and refe='G' and alt='A' |
|       13 | 0.00023650 | RESET QUERY CACHE                                                                      |
|       14 | 0.00418025 | select * from cosmic5  where chromosome=20 and position=96030 and refe='G' and alt='A' |
|       15 | 0.00023375 | RESET QUERY CACHE                                                                      |
|       16 | 0.00120075 | select * from cosmic5  where chromosome=20 and position=96030 and refe='G' and alt='A' 


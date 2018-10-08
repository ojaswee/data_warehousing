#!/bin/bash
#before starting remove profile
rm -f 03_insert_comparison_result_mysql.txt
rm -f 04_delete_comparison_result_mysql.txt

for i in `seq 1 3`;
        do
              echo "-------- $i "
              {
              time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
DROP TABLE IF EXISTS cosmic_itest;
CREATE TABLE cosmic_itest(
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
load data local infile '/home/ojaswee/masters_project/01_data/cosmic_1k.txt' into table cosmic_itest (chromosome,position,ID, refe, alt,qual,filter,info);
EOF
} &>> 03_insert_comparison_result_mysql.txt


{
time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
select count(*) from cosmic_itest;
DELETE FROM cosmic_itest where 1=1;
EOF
} &>> 04_delete_comparison_result_mysql.txt


{
time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
DROP TABLE IF EXISTS cosmic_itest;
CREATE TABLE cosmic_itest(
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
load data local infile '/home/ojaswee/masters_project/01_data/cosmic_10k.txt' into table cosmic_itest (chromosome,position,ID, refe, alt,qual,filter,info);
select count(*) from cosmic_itest;
EOF
} &>> 03_insert_comparison_result_mysql.txt

{
time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
select count(*) from cosmic_itest;
DELETE FROM cosmic_itest where 1=1;
EOF
} &>> 04_delete_comparison_result_mysql.txt


{
time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
DROP TABLE IF EXISTS cosmic_itest;
CREATE TABLE cosmic_itest(
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
load data local infile '/home/ojaswee/masters_project/01_data/cosmic_100k.txt' into table cosmic_itest (chromosome,position,ID, refe, alt,qual,filter,info);
select count(*) from cosmic_itest;
EOF
} &>> 03_insert_comparison_result_mysql.txt

{
time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
select count(*) from cosmic_itest;
DELETE FROM cosmic_itest where 1=1;
EOF
} &>> 04_delete_comparison_result_mysql.txt


{
time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
DROP TABLE IF EXISTS cosmic_itest;
CREATE TABLE cosmic_itest(
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
load data local infile '/home/ojaswee/masters_project/01_data/cosmic_1000k.txt' into table cosmic_itest (chromosome,position,ID, refe, alt,qual,filter,info);
select count(*) from cosmic_itest;
EOF
} &>> 03_insert_comparison_result_mysql.txt

{
time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
select count(*) from cosmic_itest;
DELETE FROM cosmic_itest where 1=1;
EOF
} &>> 04_delete_comparison_result_mysql.txt

done

#after completion
#cat 02_index_comparison_result.txt | grep 'real'

# mongodb

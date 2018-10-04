#!/bin/bash
#before starting remove profile
# rm -f 03_insert_comparison_result_mysql.txt
rm -f 03_insert_comparison_result_mongo.txt
rm -f 04_delete_comparison_result_mongo.txt

for i in `seq 1 3`;
        do
              echo "-------- $i "
              {
# first create collection and load data
mongo cancer --eval 'db.cosmic_itest.drop()'
              time mongoimport --db cancer --collection cosmic_itest --type csv --headerline --file /home/ojaswee/masters_project/01_data/cosmic_1k.csv
} &>> 03_insert_comparison_result_mongo.txt

#then count and delete
{
              time mongo 127.0.0.1/cancer <<EOF
db.cosmic_itest.count();
db.cosmic_itest.deleteMany({});
EOF
} &>> 04_delete_comparison_result_mongo.txt

{
# first create collection and load data
  mongo cancer --eval 'db.cosmic_itest.drop()'
              time mongoimport --db cancer --collection cosmic_itest --type csv --headerline --file /home/ojaswee/masters_project/01_data/cosmic_10k.csv
} &>> 03_insert_comparison_result_mongo.txt

#then count and delete
{
              time mongo 127.0.0.1/cancer <<EOF
db.cosmic_itest.count();
db.cosmic_itest.deleteMany({});
EOF
} &>> 04_delete_comparison_result_mongo.txt

{
# first create collection and load data
mongo cancer --eval 'db.cosmic_itest.drop()'
              time mongoimport --db cancer --collection cosmic_itest --type csv --headerline --file /home/ojaswee/masters_project/01_data/cosmic_100k.csv
} &>> 03_insert_comparison_result_mongo.txt

#then count and delete
{
              time mongo 127.0.0.1/cancer <<EOF
db.cosmic_itest.count();
db.cosmic_itest.deleteMany({});
EOF
} &>> 04_delete_comparison_result_mongo.txt

{
# first create collection and load data
mongo cancer --eval 'db.cosmic_itest.drop()'
              time mongoimport --db cancer --collection cosmic_itest --type csv --headerline --file /home/ojaswee/masters_project/01_data/cosmic_1000k.csv
} &>> 03_insert_comparison_result_mongo.txt

#then count and delete
{
              time mongo 127.0.0.1/cancer <<EOF
db.cosmic_itest.count();
db.cosmic_itest.deleteMany({});
EOF
} &>> 04_delete_comparison_result_mongo.txt

done

#after completion
#cat 03_insert_comparison_result_mongo.txt | grep 'real'

# mongodb

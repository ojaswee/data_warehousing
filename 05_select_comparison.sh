#!/bin/bash
#before starting remove profile
rm -f 05_select_comparison_result_mysql_index.txt
# rm -f 05_select_comparison_result_mongo_index.txt
#
for i in `seq 1 3`;
        do
              echo "-------- $i "
              {
              time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
SELECT ID FROM cosmic5 LIMIT 1000;
EOF
} &>> 05_select_comparison_result_mysql_index.txt

{
time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
SELECT ID FROM cosmic5 LIMIT 10000;
EOF
} &>> 05_select_comparison_result_mysql_index.txt

{
time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
SELECT ID FROM cosmic5  LIMIT 100000;
EOF
} &>> 05_select_comparison_result_mysql_index.txt

{
time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
SELECT ID FROM cosmic5 LIMIT 1000000;
EOF
} &>> 05_select_comparison_result_mysql_index.txt

done


# for i in `seq 1 3`;
#         do
#               echo "-------- $i "
#               {
#               time mongo 127.0.0.1/cancer <<EOF
#               db.cosmic.getPlanCache().clear()
#               db.cosmic.find( {} ).limit( 1000 );
# EOF
# } &>> 05_select_comparison_result_mongo_index.txt
#
# {
# time mongo 127.0.0.1/cancer <<EOF
# db.cosmic5.getPlanCache().clear()
# db.cosmic5.find( {} ).limit( 10000 );
# EOF
# } &>> 05_select_comparison_result_mongo_index.txt
#
# {
# time mongo 127.0.0.1/cancer <<EOF
# db.cosmic5.getPlanCache().clear()
# db.cosmic5.find( {} ).limit( 100000 );
# EOF
# } &>> 05_select_comparison_result_mongo_index.txt
#
# {
# time mongo 127.0.0.1/cancer <<EOF
# db.cosmic5.getPlanCache().clear()
# db.cosmic5.find( {} ).limit( 1000000);
# EOF
# } &>> 05_select_comparison_result_mongo_index.txt
# done


#after completion
#cat 02_index_comparison_result.txt | grep 'real'

# mongodb

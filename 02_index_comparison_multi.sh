#!/bin/bash
#before starting remove profile
# rm -f 02_index_comparison_result_mysql_multi.txt
rm -f 02_index_comparison_result_mongo_multi.txt

# for i in `seq 1 3`;
#         do
#               echo "-------- $i "
#               {
#               time  mysql -u root -pmain cancer <<EOF
# RESET QUERY CACHE;
# SELECT ID FROM cosmic LIMIT 1000000;
# EOF
# } &>> 02_index_comparison_result_mongo_multi.txt
#
# {
# time mysql -u root -pmain cancer <<EOF
# RESET QUERY CACHE;
# SELECT ID FROM cosmic2 LIMIT 1000000;
# EOF
# } &>> 02_index_comparison_result_mongo_multi.txt
#
# {
# time mysql -u root -pmain cancer <<EOF
# RESET QUERY CACHE;
# SELECT ID FROM cosmic3 LIMIT 1000000;
# EOF
# } &>> 02_index_comparison_result_mongo_multi.txt
#
#
# {
# time mysql -u root -pmain cancer <<EOF
# RESET QUERY CACHE;
# SELECT ID FROM cosmic4 LIMIT 1000000;
# EOF
# } &>> 02_index_comparison_result_mongo_multi.txt
#
# {
# time mysql -u root -pmain cancer <<EOF
# RESET QUERY CACHE;
# SELECT ID FROM cosmic5 LIMIT 1000000;
# EOF
# } &>> 02_index_comparison_result_mongo_multi.txt
#
# done

#after completion
#cat 02_index_comparison_result_mysql.txt | grep 'real'

###### mongodb
for i in `seq 1 3`;
        do
              echo "-------- $i "
              {
              time  mongo 127.0.0.1/cancer <<EOF
db.cosmic.getPlanCache().clear()
db.cosmic.find( {} ).limit( 1000000);
EOF
} &>> 02_index_comparison_result_mongo_multi.txt

{
time  mongo 127.0.0.1/cancer <<EOF
  db.cosmic2.getPlanCache().clear()
  db.cosmic2.find( {} ).limit( 1000000);
EOF
} &>> 02_index_comparison_result_mongo_multi.txt

{
time  mongo 127.0.0.1/cancer <<EOF
  db.cosmic3.getPlanCache().clear()
  db.cosmic3.find( {} ).limit( 1000000);
EOF
} &>> 02_index_comparison_result_mongo_multi.txt

{
time  mongo 127.0.0.1/cancer <<EOF
  db.cosmic4.getPlanCache().clear()
  db.cosmic4.find( {} ).limit( 1000000);
EOF
} &>> 02_index_comparison_result_mongo_multi.txt
{
time  mongo 127.0.0.1/cancer <<EOF
  db.cosmic5.getPlanCache().clear()
  db.cosmic5.find( {} ).limit( 1000000);
EOF
} &>> 02_index_comparison_result_mongo_multi.txt

done

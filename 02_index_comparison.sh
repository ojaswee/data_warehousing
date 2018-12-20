#!/bin/bash
#before starting remove profile
# rm -f 02_index_comparison_result_mysql.txt
rm -f 02_index_comparison_result_mongo.txt

# for i in `seq 1 3`;
#         do
#               echo "-------- $i "
#               {
#               time  mysql -u root -pmain cancer <<EOF
# RESET QUERY CACHE;
# select * from cosmic where chromosome=20 and position=96030 and refe='G' and alt='A';
# EOF
# } &>> 02_index_comparison_result_mysql.txt
#
# {
# time mysql -u root -pmain cancer <<EOF
# RESET QUERY CACHE;
# select * from cosmic2 where chromosome=20 and position=96030 and refe='G' and alt='A';
# EOF
# } &>> 02_index_comparison_result_mysql.txt
#
# {
# time mysql -u root -pmain cancer <<EOF
# RESET QUERY CACHE;
# select * from cosmic3 where chromosome=20 and position=96030 and refe='G' and alt='A';
# EOF
# } &>> 02_index_comparison_result_mysql.txt
#
#
# {
# time mysql -u root -pmain cancer <<EOF
# RESET QUERY CACHE;
# select * from cosmic4 where chromosome=20 and position=96030 and refe='G' and alt='A';
# EOF
# } &>> 02_index_comparison_result_mysql.txt
#
# {
# time mysql -u root -pmain cancer <<EOF
# RESET QUERY CACHE;
# select * from cosmic5 where chromosome=20 and position=96030 and refe='G' and alt='A';
# EOF
# } &>> 02_index_comparison_result_mysql.txt
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
db.cosmic.find({"CHROM" :20 , "POS":96030 , "REF":"G" , "ALT":"A"});
EOF
} &>> 02_index_comparison_result_mongo.txt

{
time  mongo 127.0.0.1/cancer <<EOF
  db.cosmic2.getPlanCache().clear()
  db.cosmic2.find({"CHROM" :20 , "POS":96030 , "REF":"G" , "ALT":"A"});
EOF
} &>> 02_index_comparison_result_mongo.txt

{
time  mongo 127.0.0.1/cancer <<EOF
  db.cosmic3.getPlanCache().clear()
  db.cosmic3.find({"CHROM" :20 , "POS":96030 , "REF":"G" , "ALT":"A"});
EOF
} &>> 02_index_comparison_result_mongo.txt

{
time  mongo 127.0.0.1/cancer <<EOF
  db.cosmic4.getPlanCache().clear()
  db.cosmic4.find({"CHROM" :20 , "POS":96030 , "REF":"G" , "ALT":"A"});
EOF
} &>> 02_index_comparison_result_mongo.txt
{
time  mongo 127.0.0.1/cancer <<EOF
  db.cosmic5.getPlanCache().clear()
  db.cosmic5.find({"CHROM" :20 , "POS":96030 , "REF":"G" , "ALT":"A"});
EOF
} &>> 02_index_comparison_result_mongo.txt

done

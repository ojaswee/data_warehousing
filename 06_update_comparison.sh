#!/bin/bash
#before starting remove profile
rm -f 06_update_comparison_result_mysql.txt

for i in `seq 1 3`;
        do
              echo "-------- $i "
              {
              time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
UPDATE cosmic set alt='ZZZ' WHERE ID in (SELECT ID  FROM cosmic2 where  RAND() <= 0.00022);
EOF
} &>> 06_update_comparison_result_mysql.txt

{
time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
UPDATE cosmic set alt='ZZZ' WHERE ID in (SELECT ID  FROM cosmic2 where  RAND() <= 0.0022);
EOF
} &>> 06_update_comparison_result_mysql.txt


{
time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
UPDATE cosmic set alt='ZZZ' WHERE ID in (SELECT ID  FROM cosmic2 where  RAND() <= 0.022);
EOF
} &>> 06_update_comparison_result_mysql.txt


{
time  mysql -u root -pmain cancer <<EOF
RESET QUERY CACHE;
UPDATE cosmic set alt='ZZZ' WHERE ID in (SELECT ID  FROM cosmic2 where  RAND() <= 0.22);
EOF
} &>> 06_update_comparison_result_mysql.txt

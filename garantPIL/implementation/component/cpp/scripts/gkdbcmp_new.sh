#!/usr/local/bin/bash

cd C:/Etalon/maximum

LOG_DIR=./logs

rm -f $LOG_DIR/gkdbcmp_new*.res $LOG_DIR/gkdbcmp_new*.log $3

$4/gkdbcmp -n -t -threads:3 -r $LOG_DIR/gkdbcmp_new1.res $1 $2 | tee $LOG_DIR/gkdbcmp_new1.log &
$4/gkdbcmp -p -t -Attrs -r $LOG_DIR/gkdbcmp_new2.res $1 $2 | tee $LOG_DIR/gkdbcmp_new2.log &
$4/gkdbcmp -p -n -r $LOG_DIR/gkdbcmp_new3.res $1 $2 | tee $LOG_DIR/gkdbcmp_new3.log &
$4/gkdbcmp -r $LOG_DIR/gkdbcmp_new4.res $1 $2 Attrs | tee $LOG_DIR/gkdbcmp_new4.log &
$4/gkdbcmp -r $LOG_DIR/gkdbcmp_new5.res $1 $2 NewCorr | tee $LOG_DIR/gkdbcmp_new5.log &

wait

cat $LOG_DIR/gkdbcmp_new*.res > $3

exit `cat $3`

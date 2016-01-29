#!/usr/local/bin/bash

cd C:/Etalon/maximum

LOG_DIR=./logs

rm -f $LOG_DIR/gkdbcmp*.res $LOG_DIR/gkdbcmp*.log $3

$4/gkdbcmp -n -t -threads:3 -r $LOG_DIR/gkdbcmp1.res $1 $2 | tee $LOG_DIR/gkdbcmp1.log &
$4/gkdbcmp -p -t -Attrs -r $LOG_DIR/gkdbcmp2.res $1 $2 | tee $LOG_DIR/gkdbcmp2.log &
$4/gkdbcmp -p -n -r $LOG_DIR/gkdbcmp3.res $1 $2 | tee $LOG_DIR/gkdbcmp3.log &
$4/gkdbcmp -r $LOG_DIR/gkdbcmp4.res $1 $2 Attrs | tee $LOG_DIR/gkdbcmp4.log &
$4/gkdbcmp -r $LOG_DIR/gkdbcmp5.res $1 $2 NewCorr | tee $LOG_DIR/gkdbcmp5.log &

wait

cat $LOG_DIR/gkdbcmp*.res > $3

exit `cat $3`

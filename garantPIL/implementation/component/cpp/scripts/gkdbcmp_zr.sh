#!/usr/local/bin/bash

cd C:/Etalon/maximum

LOG_DIR=./logs

rm -f $LOG_DIR/gkdbcmp_zr*.res $LOG_DIR/gkdbcmp_zr*.log $3

$4/gkdbcmp -n -t -threads:3 -r $LOG_DIR/gkdbcmp_zr1.res $1 $2 | tee $LOG_DIR/gkdbcmp_zr1.log &
$4/gkdbcmp -p -t -Attrs -r $LOG_DIR/gkdbcmp_zr2.res $1 $2 | tee $LOG_DIR/gkdbcmp_zr2.log &
$4/gkdbcmp -p -n -r $LOG_DIR/gkdbcmp_zr3.res $1 $2 | tee $LOG_DIR/gkdbcmp_zr3.log &
$4/gkdbcmp -r $LOG_DIR/gkdbcmp_zr4.res $1 $2 Attrs | tee $LOG_DIR/gkdbcmp_zr4.log &
$4/gkdbcmp -r $LOG_DIR/gkdbcmp_zr5.res $1 $2 NewCorr | tee $LOG_DIR/gkdbcmp_zr5.log &

wait

cat $LOG_DIR/gkdbcmp_zr*.res > $3

exit `cat $3`

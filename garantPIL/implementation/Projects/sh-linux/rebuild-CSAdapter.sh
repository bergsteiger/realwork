#!/bin/bash

LOG_FILE=rebuild-SCAdapter.log

{
	echo "[clean everything]: " `date` && ./clean-all.sh
	echo "[update CVS]: "       `date` && ./update.sh
	echo "[build Makefiles]:"   `date` && ./CSAdapter_unix.mwc.sh

	echo "[build the CSAdapter]: " `date`

	cd $GARANT_ROOT/garantPIL/implementation/Projects
	if make 
	then 
		RESULT="success"
	else
		RESULT="FAILURE"
	fi

	cd $GARANT_ROOT/garantPIL/implementation/Projects/sh-linux
	echo "[build $RESULT]: send e-mail notification " `date`  

} &> $LOG_FILE

7z a ${LOG_FILE}.7z $LOG_FILE

./send-build-log.py "CSAdapter build $RESULT" ${LOG_FILE}.7z

echo build $RESULT 

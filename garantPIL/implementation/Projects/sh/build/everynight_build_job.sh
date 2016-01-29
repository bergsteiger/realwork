#!/bin/sh
# Start directory must be MPCXC root.

# sh .profile MPCXC fragment

# GARANT {
export MPCXC_PATH_TO_ACE_WRAPPERS=/mnt/nfs/Garant-external/2006-03-07/winNT+stlport/ACE_wrappers # not used here

export MPCXC_MIRROR_HOME=/home/compile
export MPCXC_USER_HOME=/home/$USER

export PATH=$MPCXC_USER_HOME/build:$MPCXC_MIRROR_HOME/build:$PATH # should be $USER-independent

export MPCXC_ROOT=$MPCXC_USER_HOME/pilotcvs
export MPCXC_CVS_USER=nemesis # may be != $USER !

export XERCES_ROOT=$MPCXC_MIRROR_HOME/xerces_260 # should be $USER-independent
export MPCXC_PATH_TO_LOKI=$MPCXC_PATH_TO_ACE_WRAPPERS/../loki # should be $USER-independent
export MPCXC_PATH_TO_BZLIB=$MPCXC_PATH_TO_ACE_WRAPPERS/../bzlib # should be $USER-independent

export LOKI_ROOT=$MPCXC_ROOT/src/loki # user-dependent due to non-lite loki copying at level 2 install

export BOOST_ROOT=/usr/local/boost

mkdir -p $MPCXC_ROOT
cd $MPCXC_ROOT

echo "Current directory to start garant build from must be: $MPCXC_ROOT."
echo "Garant compile on UNIX ready."
# GARANT }

################

taoace_target=`$MPCXC_ROOT/src/garant6x/implementation/Projects/sh/build/uname2target.rb`

if test "$taoace_target" = "" ; then
echo "mpcxc_full_rebuild_ace: FATAL: target platform = $taoace_target not supported."
exit
fi	  

taoace_target=$taoace_target"_static"

target=$taoace_target

################

uname_cust=`uname -s -r -m -p`

echo "/bin/sh local build on: $uname_cust" > mail_build.txt

cur_date=`date`

echo "mpcxc_update_cvs_daily started at: $cur_date." >> mail_build.txt

mpcxc_update_cvs_daily y # should not use make update_cvs

cp -f $MPCXC_ROOT/src/garant6x/implementation/Projects/sh/build/* $MPCXC_USER_HOME/build/
chmod 755 $MPCXC_USER_HOME/build/*

cp -f $MPCXC_ROOT/src/garant6x/implementation/Projects/sh/build/Makefile Makefile

cur_date=`date`

echo "mpcxc_update_cvs_daily finished at: $cur_date." >> mail_build.txt

################

cp -f mail_build.txt mail_build_server_static.txt
echo "make clean_garant_server_static started at: $cur_date." >> mail_build_server_static.txt

make clean_garant_server_static
make garant_server_static

cp -f make_partial.log make_partial.server_static.log
recode koi8-r..ms-cyrl/CR-LF < make_partial.server_static.log >  make_partial.server_static.log.crlf.txt
rm -f make_partial.server_static.zip
zip make_partial.server_static.zip make_partial.server_static.log.crlf.txt

cur_date=`date`

echo "make garant_server_static finished at: $cur_date." >> mail_build_server_static.txt

################

#cp -f mail_build.txt mail_build_tools_static.txt
#echo "make clean_garant_tools_static started at: $cur_date." >> mail_build_tools_static.txt
#
#make clean_garant_tools_static
#make garant_tools_static
#
#cp -f make_partial.log make_partial.tools_static.log
#recode koi8-r..ms-cyrl/CR-LF < make_partial.tools_static.log >  make_partial.tools_static.log.crlf.txt
#rm -f make_partial.tools_static.zip
#zip make_partial.tools_static.zip make_partial.tools_static.log.crlf.txt
#
#cur_date=`date`
#
#echo "make garant_tools_static finished at: $cur_date." >> mail_build_tools_static.txt

################

make_error=`grep -i "ïÛÉÂËÁ" make_partial.server_static.log`
if test "$make_error" = ""; then
success_txt="SUCCESS"
else
success_txt="FAILURE"
fi

echo "See log attached for details." >> mail_build_server_static.txt
mail -s "BUILD $success_txt -  garant_server_unix_static.mwc." -a make_partial.server_static.zip newdev@garant.ru < mail_build_server_static.txt

################

#make_error=`grep -i "ïÛÉÂËÁ" make_partial.tools_static.log`
#if test "$make_error" = ""; then
#success_txt="SUCCESS"
#else
#success_txt="FAILURE"
#fi
#
#echo "See log attached for details." >> mail_build_tools_static.txt
#mail -s "BUILD garant_tools_unix_static.mwc $target $success_txt." -a make_partial.tools_static.zip newdev@garant.ru < mail_build_tools_static.txt

################

at 6:00 -f $MPCXC_ROOT/src/garant6x/implementation/Projects/sh/build/everynight_build_job.sh
atq

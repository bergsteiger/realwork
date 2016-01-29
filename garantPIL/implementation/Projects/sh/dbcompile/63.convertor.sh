#!/bin/sh

if test "$1" = "" ; then
echo "Usage: 63.convertor.sh <MPCXC_ROOT> <opt_flag> <base_name> <gc_ini_file>"
echo "Current directory must be your testbase_dir/sh."
exit
fi

echo "63.convertor.sh ..."

short_sys_name=`uname -s`
target=""
taoace_target=""
case ${short_sys_name} in
	*Linux*)
		target="i686_pc_linux_gnu_gcc_server_debug"
		taoace_target="i686_pc_linux_gnu_gcc"
		;;
	*FreeBSD*)
		target="i686_pc_freebsd_gcc_server_debug"
		taoace_target="i686_pc_freebsd_gcc"
		;;
esac
if test "$target" = "" ; then
echo "mpcxc_full_rebuild_ace: FATAL: OS = $short_sys_name not supported."
exit
fi	  

if test "$2" = "O3" ; then
echo "Optimize using -O3"
target=$target"_O3"
else
echo "Optimize using -O0"
fi

export MPCXC_ROOT=$1

base_name=$3
gc_ini_file=$4

future_scripts_path=$MPCXC_ROOT/src/garant6x/implementation/Projects/sh/build
export MPCXC_SH=$future_scripts_path
ace_config_path=$MPCXC_ROOT/src/common/templates/mpc/make/TAOACE
export MPCXC_CONFIG="" # ensure no config
export MPCXC_TARGET=$target

export TAOACE_MPCXC_ROOT=$MPCXC_ROOT
export TAOACE_MPCXC_TARGET=$taoace_target

export ACE_ROOT=$TAOACE_MPCXC_ROOT/src
export TAO_ROOT=$ACE_ROOT/TAO

export LOKI_ROOT="/home2/grigorio/samba2/2005-10-11"
export XERCES_ROOT="/home/grigorio/tuning/xerces-c-src_2_6_0"


export PATH=/usr/local/gcc402/bin:/usr/local/gcc344/bin:/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/gcc402/lib:/usr/local/gcc344/lib:/usr/local/lib:$MPCXC_ROOT/out/$MPCXC_TARGET/lib:$TAOACE_MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/lib:$XERCES_ROOT/lib:$LD_LIBRARY_PATH


cd ..

testbase_dir=$PWD

#date 24/09/2004

#REM Копируем в каталог NSRC изменяющиеся для документов на контроле NSRы
cp -af $testbase_dir/nsrc/original/* $testbase_dir/nsrc/
cp -af $testbase_dir/nsrc/original/dict/* $testbase_dir/nsrc/dict/

$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gc -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/grev -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsetrev -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gl -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gm -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/hisync -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsplit -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsetname -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gctx -z

### make garant db '$base_name' ###

#REM Компилируем базу $base_name
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gc -6 $testbase_dir/ini/$gc_ini_file $testbase_dir/$base_name
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/fixnames $testbase_dir/$base_name
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/grev $testbase_dir/$base_name -r:24/09/2004
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsetrev $testbase_dir/$base_name
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/enumparas $testbase_dir/$base_name
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/newrefs $testbase_dir/$base_name
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gl -w $testbase_dir/$base_name

#REM конвертим базу $base_name
mkdir -p $testbase_dir/before_convert/temp
mkdir -p $testbase_dir/after_convert/temp
cp -f $testbase_dir/$base_name.* $testbase_dir/before_convert/temp/
cp -f $testbase_dir/$base_name.* $testbase_dir/after_convert/temp/

#REM переносим базу $base_name. Потом понадобится для enumparas
mkdir -p $testbase_dir/before_convert/enumparas
cp -f $testbase_dir/$base_name.* $testbase_dir/before_convert/enumparas
rm -f $testbase_dir/$base_name.*

$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/EndtConvertor -type all \
-from $testbase_dir/before_convert/temp/$base_name \
-to $testbase_dir/after_convert/temp/$base_name \
-editions $testbase_dir/edis/edis_or

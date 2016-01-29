#!/bin/sh

if test "$1" = "" ; then
echo "Usage: 63.start_tool.sh <MPCXC_ROOT> <opt_flag> <tool_name> [<arg1> [<arg2> ...]] "
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
echo $PWD

$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/$3 $4 $5 $6 $7 $8 $9

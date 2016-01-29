#!/bin/sh

if test "$1" = "" ; then
echo "Usage: mwc.sh never must be run manually."
exit
fi

if test "$MPCXC_SH" = ""; then
echo "You must export MPCXC_SH env to point to the shell scripts of your Multi Platform Common eXtra Code."
exit
fi

if test "$MPCXC_ROOT" = ""; then
echo "You must export MPCXC_ROOT env to point to the root of your Multi Platform Common eXtra Code."
exit
fi

if test "$MPCXC_TARGET" = ""; then
echo "You must export MPCXC_TARGET env: currently supported: i686-pc-linux-gnu i686-pc-freebsd."
exit
fi

if test "$MPCXC_ROOT" != "$PWD"; then
echo "mwc.sh: internal error: PWD != MPCXC_ROOT."
exit
fi

target=$MPCXC_TARGET

# $MPCXC_ROOT/cfg/common: default.rel

mwc_path=$1
mwc_file=$2
mwc_global=$3

echo "mwc.sh: mwc_file = $mwc_file"

chmod 755 $mwc_global

if test "$MPCXC_CONFIG" != ""; then
config_dir=$MPCXC_CONFIG
else
config_dir=$MPCXC_MIRROR_HOME/pilotcvs/src/garant6x/implementation/Projects/sh/build/MPC/config
fi

echo "mwc.sh: config_dir = $config_dir"

export ACE_ROOT=$MPCXC_ROOT/src
export TAO_ROOT=$ACE_ROOT/TAO

$MPCXC_MIRROR_HOME/pilotcvs/src/garant6x/implementation/Projects/sh/build/MPC/mwc.pl \
-type make \
-template $MPCXC_ROOT/src/shared/support/mpc/make/make-generic.mpd \
-include $MPCXC_ROOT/src/shared/support/mpc \
-include $MPCXC_ROOT/src/shared/support/mpc/make \
-include $MPCXC_ROOT/src/garant6x/implementation/Projects/common \
-include $config_dir \
-global `$mwc_global` \
-feature_file $MPCXC_ROOT/src/shared/support/mpc/make/TAOACE/global.features \
-value_template configurations=$target \
-value_template ln="cp -p" \
-value_template workspace_name=$mwc_file \
$mwc_path/$mwc_file

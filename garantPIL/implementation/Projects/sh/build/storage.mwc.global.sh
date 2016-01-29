#!/bin/sh

if test "$TAOACE_MPCXC_ROOT" = ""; then
echo "You must export TAOACE_MPCXC_ROOT for TAO/ACE based workspaces."
exit
fi

if test "$TAOACE_MPCXC_TARGET" = ""; then
echo "You must export TAOACE_MPCXC_TARGET for TAO/ACE based workspaces."
exit
fi

echo "global+ace+tao+boost+storages-main.mpb"

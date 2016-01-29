#!/bin/sh

if test "$TAOACE_MPCXC_ROOT" = ""; then
echo "You must export TAOACE_MPCXC_ROOT for garant_server.mwc."
exit
fi

if test "$TAOACE_MPCXC_TARGET" = ""; then
echo "You must export TAOACE_MPCXC_TARGET for garant_server.mwc."
exit
fi

if test "$LOKI_ROOT" = ""; then
echo "You must export LOKI_ROOT for garant_server.mwc."
exit
fi

if test "$XERCES_ROOT" = ""; then
echo "You must export XERCES_ROOT for garant_server.mwc."
exit
fi

if test "$BOOST_ROOT" = ""; then
echo "You must export BOOST_ROOT for garant_server.mwc."
exit
fi

echo "global+ace+tao+boost-main.mpb"

#!/bin/sh

MWC_PARAMETERS="\
-type     make \
-include  $GARANT_ROOT/shared/support/mpc \
-include  $GARANT_ROOT/shared/support/mpc/make-linux \
-include  $GARANT_ROOT/garantPIL/implementation/Projects/common \
-global   $GARANT_ROOT/shared/support/mpc/make-linux/garant.mpb \
-template $GARANT_ROOT/shared/support/mpc/make-linux/make-garant.mpd"

# change abs path & remove win32 directory 
sed -i -e 's/[Ww]:/$(GARANT_ROOT)/' -e 's/^.*win32.*$//' $GARANT_ROOT/garantPIL/implementation/Projects/common/project-common-includes.mpc >/dev/null 2>&1

cd $GARANT_ROOT/garantPIL/implementation/Projects
$ACE_ROOT/bin/mwc.pl $MWC_PARAMETERS garant_CSAdapter_unix.mwc

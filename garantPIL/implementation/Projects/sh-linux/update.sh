#!/bin/sh

CVS_UPDATE='cvs -q up -Pd'

cd $GARANT_ROOT/shared                            && $CVS_UPDATE
cd $GARANT_ROOT/garantPIL                         && $CVS_UPDATE


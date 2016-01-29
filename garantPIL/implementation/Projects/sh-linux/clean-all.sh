#!/bin/sh

find $GARANT_ROOT -type f -name "*.[od]"     -delete
find $GARANT_ROOT -type f -name "*[CS].h"    -delete
find $GARANT_ROOT -type f -name "*[CS].inl"  -delete
find $GARANT_ROOT -type f -name "*[CS].cpp"  -delete
find $GARANT_ROOT -type f -name "*.idl.dup"  -delete
find $GARANT_ROOT -type f -name "Makefile.*" -delete
find $GARANT_ROOT -type f -name "Makefile"   -delete

rm -r -f $GARANT_ROOT/lib/*

cd $GARANT_ROOT/shared/Core/fix/corba && cvs -q up -Pd &> /dev/null

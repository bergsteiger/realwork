if "%1"=="" goto exit

set CVSROOT=:pserver:%1@cvs.garant.ru:/cvs

cd /d w:\

cvs -q co -P archi
cvs -q co -P build_scripts
cvs -q co -P common
cvs -q co -P garant6x
cvs -q co -P garantPIL
cvs -q co -P MDProcess
cvs -q co -P quality
cvs -q co -P shared
cvs -q co -P garantServer

:exit
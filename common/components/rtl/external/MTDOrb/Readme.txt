For build this project you can use ant (www.apache.org). Before build project rename
file build.properties.pattern in build.properties and set specific for your machine
parameters, then start build.bat (for Windows platform) or build.sh (for Linux)
in root project folder. After compile process all binary files will be copy into
build forlder.

For additional information please visit web site http://www.m-g.ru/corba
To subscribe on news about MT_DORB send e-mail with subject 'subscribe' to corba@m-g.ru

We recommend that you place the MTDORB_UCUtils.dll ( or MTDORB_UCUtils.so for Linux)
in the  Windows\System directory (or Windows\System32 for WinNT and Win2K and
/lib for Linux).

It is also possible to link MTDORB_UCUtils.* inside program itself. Just
set build.utillibrary=off in build.properties

Main MTDORB author: Oleg V. Safonov <safonov@m-g.ru>

if "%1"=="" goto exit

set CVSROOT=:pserver:%1@cvs.garant.ru:/cvs

set CVS_UPDATE=cvs -Q update -P -d
set SVN_UPDATE=svn up

set VCS_UPDATE=%CVS_UPDATE%

cd /d w:\archi
%VCS_UPDATE%

cd /d w:\build_scripts
%VCS_UPDATE%

cd /d w:\common
%VCS_UPDATE%

cd /d w:\garant6x
%VCS_UPDATE%

cd /d w:\garantPIL
%VCS_UPDATE%

cd /d w:\MDProcess
%VCS_UPDATE%

cd /d w:\quality
%VCS_UPDATE%

cd /d w:\shared
%VCS_UPDATE%

cd /d w:\garantServer
%VCS_UPDATE%

if "%1" NEQ "lulin" goto exit
if "%COMPUTERNAME%" NEQ "LULIN-NEST" goto exit

cd /d H:\Dropbox\_CVS\archi
%VCS_UPDATE%

cd /d H:\Dropbox\_CVS\build_scripts
%VCS_UPDATE%

cd /d H:\Dropbox\_CVS\common
%VCS_UPDATE%

cd /d H:\Dropbox\_CVS\garant6x
%VCS_UPDATE%

cd /d H:\Dropbox\_CVS\garantPIL
%VCS_UPDATE%

cd /d H:\Dropbox\_CVS\MDProcess
%VCS_UPDATE%

cd /d H:\Dropbox\_CVS\quality
%VCS_UPDATE%

cd /d H:\Dropbox\_CVS\shared
%VCS_UPDATE%

cd /d H:\Dropbox\_CVS\garantServer
%VCS_UPDATE%

:exit
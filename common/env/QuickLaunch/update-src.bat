@echo off
if "%1"=="" goto exit

set VCS=cvs

set OUTFILE=update-vcs-out.log%VCS%
set ERRFILE=update-vcs-err.log%VCS%

cd /d "%USERPROFILE%\logs"

call update-vcs.bat %1 >%OUTFILE% 2>%ERRFILE%

cd /d "%USERPROFILE%\logs"

grep "^\s*C "   %OUTFILE%
grep "conflict" %ERRFILE%

pause

:exit
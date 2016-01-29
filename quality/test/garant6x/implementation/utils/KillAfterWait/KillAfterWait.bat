cls
@echo off
rem Only run from Utils script folder !!!
echo Waiting for %2 secs, then kill "%1" ...
"%~d0%~p0..\PsTools\sleep.exe" %2
"%~d0%~p0..\PsTools\pskill.exe" %1
exit
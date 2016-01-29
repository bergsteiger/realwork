@echo off
title ARCHI group nightbuild script
SET BUILDROOT=D:\DT_HOURLY
SET DELPHILIB=D:\nightbuild\delphi
SET KTOPIC=288789686

if EXIST W:\ (
 echo Another build in progress!
 exit /b
)

subst W: %BUILDROOT%
set CVSROOT=:pserver:fireton@developer.garant.ru:/export/home/cvs
W:
cd W:\
 
rem goto build 
 
if "%1"=="clean" (
 rmdir /S /Q W:\common
 cvs -q co -P common
) else (
 cd W:\common
 cvs -q update -P -A -d -C
 del /S .#*.* 1>nul 2>nul
)

:build

rmdir /S /Q %BUILDROOT%\_out
mkdir %BUILDROOT%\_out\units
mkdir %BUILDROOT%\_out\exe

cd W:\common\components\DailyTest
copy /Y W:\common\components\DailyTest\_cfg\DailyTest.cfg
KPageTool.exe -ORBInitRef NameService=corbaloc::1.2@mdp:5053/NameService -login builder -password builder -operation PA_GET_LABEL -page_id %KTOPIC% -file labels.txt
echo h4.Ñáîðêà %DATE% %TIME% > kpage.txt
dcc32 -Q -B -U%DELPHILIB% -R%DELPHILIB% -E%BUILDROOT%\_out\exe -N%BUILDROOT%\_out\units DailyTest.dpr > %BUILDROOT%\DailyTest.build.log
if ERRORLEVEL 1 (
 tagtool labels.txt +test_failed -test_done
 echo {color:red}*ÎØÈÁÊÈ ÏÐÈ ÑÁÎÐÊÅ!*{color} >> kpage.txt
 echo {code} >> kpage.txt
 type %BUILDROOT%\DailyTest.build.log >> kpage.txt
 echo {code} >> kpage.txt
 
 net use \\archi\archi /D /Y
 net use s: \\archi\archi /USER:PU\tech archi!tech
 rmdir /Q /S S:\exe\!hourly-test
 mkdir S:\exe\!hourly-test
 xcopy %BUILDROOT%\DailyTest.build.log S:\exe\!hourly-test\ /S /Q
 net use s: /D /Y
 
) else (
 tagtool labels.txt -test_failed +test_done
 echo {color:green}*ÓÑÏÅØÍÎ*{color} >> kpage.txt
 
 rem net use \\archi\archi /D /Y
 rem net use s: \\archi\archi /USER:PU\tech archi!tech
 rmdir /Q /S H:\exe\!hourly-test
 mkdir H:\exe\!hourly-test
 xcopy %BUILDROOT%\_out\exe\*.* H:\exe\!hourly-test\ /S /Q
 rem net use s: /D /Y
  
 echo Çàáðàòü ñáîðêó ìîæíî â {noformat}\\archi\archi\exe\!hourly-tests{noformat} >> kpage.txt
)
KPageTool.exe -ORBInitRef NameService=corbaloc::1.2@mdp:5053/NameService -login builder -password builder -operation PA_SET_LABEL -page_id %KTOPIC% -file labels.txt
KPageTool.exe -ORBInitRef NameService=corbaloc::1.2@mdp:5053/NameService -login builder -password builder -operation PA_SET -page_id %KTOPIC% -file kpage.txt
del kpage.txt
del labels.txt
subst W: /D
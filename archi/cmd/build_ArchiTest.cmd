@echo off
set PROJNAME=ArchiTest
set PROJDIR=W:\archi\source\projects\archi
set OUTDIR=c:\temp\architest
SET BUILDROOT="C:\Program Files\Borland\Delphi\Bin"

echo.
echo Compiling %PROJNAME%...
copy /Y W:\archi\cmd\_cfg\%PROJNAME%.cfg %PROJDIR% >nul
mkdir %OUTDIR%
pushd %PROJDIR%

dcc32 -Q -B -U%BUILDROOT%\delphi -R%BUILDROOT%\delphi -DNBUILD -E%OUTDIR% %PROJNAME%.dpr > %OUTDIR%\%PROJNAME%.build.log

if ERRORLEVEL 1 (
 echo Compile ERROR!
) else (
 echo Success!
) 
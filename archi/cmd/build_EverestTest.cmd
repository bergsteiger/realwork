subst M: /D
subst M: "c:\Work\binout\exe\1.2"

@echo off
set PROJNAME=EverestLiteTest
set PROJDIR=w:\archi\source\projects\Everest\Lite\7.0\Express
set OUTDIR=C:\Temp\EverestLiteTest
SET BUILDROOT="c:\Program Files (x86)\Borland\Delphi7\Bin"

echo.
echo Compiling %PROJNAME%...
copy /Y W:\archi\cmd\_cfg\%PROJNAME%.cfg %PROJDIR% >nul
mkdir %OUTDIR%
pushd %PROJDIR%

"c:\Program Files (x86)\Borland\Delphi7\Bin\dcc32.exe" -Q -B -Uc:\Work\binout\Units -Rc:\Work\binout\BPL -DNBUILD -E%OUTDIR% %PROJNAME%.dpr > %OUTDIR%\%PROJNAME%.build.log

if ERRORLEVEL 1 (
 echo Compile ERROR!
) else (
 echo Success!
) 
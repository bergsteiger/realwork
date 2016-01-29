subst W: /D
subst M: /D

if "%1"=="clean" (
 rmdir /S /Q %BUILDROOT%\cvs
 rmdir /S /Q %BUILDROOT%\env

 mkdir %BUILDROOT%\cvs
 mkdir %BUILDROOT%\env
) else (
 rmdir /S /Q %BUILDROOT%\env\out
)

subst W: %BUILDROOT%\cvs
subst M: %BUILDROOT%\env

if "%1"=="clean" (
 pushd W:\
 cvs -q co -A -P archi
 cvs -q co -A -P common
 cvs -q co -A -P shared
 cvs -q co -A -P MDProcess
 cvs -q co -A -P build_scripts
 popd
) else (
 pushd W:\archi
 cvs -q update -A -P -d -C
 del /S .#*.* 1>nul 2>nul
 popd
 pushd W:\common
 rem cvs -q update -A -P -A -d -C
 cvs -q update -A -P -d
 del /S .#*.* 1>nul 2>nul
 popd
 rem pushd W:\build_scripts
 rem cvs -q update -A -P -A -d -C
 rem del /S .#*.* 1>nul 2>nul
 rem popd
 pushd W:\shared
 cvs -q update -A -P -d -C
 del /S .#*.* 1>nul 2>nul
 popd
 pushd W:\MDProcess
 cvs -q update -A -P -d -C
 del /S .#*.* 1>nul 2>nul
 popd
)
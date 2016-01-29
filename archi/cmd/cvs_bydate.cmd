SET CVSDATE=2015-03-20 02:00 

subst W: /D
subst M: /D

rmdir /S /Q %BUILDROOT%\cvs
rmdir /S /Q %BUILDROOT%\env
mkdir %BUILDROOT%\cvs
mkdir %BUILDROOT%\env

subst W: %BUILDROOT%\cvs
subst M: %BUILDROOT%\env

pushd W:\
cvs -q co -A -P -D "%CVSDATE%" archi
cvs -q co -A -P -D "%CVSDATE%" common
cvs -q co -A -P -D "%CVSDATE%" shared
cvs -q co -A -P -D "%CVSDATE%" MDProcess
cvs -q co -A -P -D "%CVSDATE%" build_scripts
popd

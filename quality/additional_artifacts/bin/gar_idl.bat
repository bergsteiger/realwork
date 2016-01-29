@echo off

set WRK_ROOT=W:\garantPIL\implementation\component
set IDL_ROOT=%WRK_ROOT%\idl
set CPP_ROOT=%WRK_ROOT%\cpp

for /f "tokens=*" %%a in ('cd') do set CUR_PATH=%%a

set CPP_PATH=%CUR_PATH:\idl\=\cpp\%

echo Output is: %CPP_PATH%
rem C:\bin\ACE_wrappers\TAO\tao\PortableInterceptor.pidl 
if not `%1` == `` echo Compile %1 & tao_idl -Cw -D_TAO_IDL -I%ACE_ROOT% -I%ACE_ROOT%\TAO -I%ACE_ROOT%\TAO\tao -I%IDL_ROOT% -I.. -I..\.. -o %CPP_PATH% %1
if     `%1` == `` for /f "tokens=*" %%a in ('dir /b *.idl') do echo Compile %%a & tao_idl -Cw -D_TAO_IDL -I%ACE_ROOT% -I%ACE_ROOT%\TAO -I%ACE_ROOT%\TAO\tao -I%IDL_ROOT% -I.. -I..\.. -o %CPP_PATH% %%a

rem if not `%1` == `` echo Compile %1 & tao_idl -Cw -D_TAO_IDL -IC:\bin\1 %1

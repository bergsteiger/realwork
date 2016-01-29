@echo off & setlocal
:: GARANT {

 :main
  :main.begin

    set PATH=%ACE_ROOT%\BIN;%PATH%

    set MPC_EXEC=%ACE_ROOT%\BIN\MPC.PL
    set MPC_TMPL=W:\COMMON\TEMPLATES\MPC
    set MPC_PROJECTS=W:\GARANTPIL\IMPLEMENTATION\PROJECTS
    set MPC_PROJECTS_TARGETS=%MPC_PROJECTS%\TARGETS
    set MPC_PROJECTS_LIBS=%MPC_PROJECTS%\LIBS
    set MPC_TYPE=vc8
    if "%2" EQU "both" (
    	set MPC_ADAPTERCLIENT=Target%1Client
	set MPC_ADAPTERSERVER=Target%1Server
    )
    if "%2" EQU "client" (
    	set MPC_ADAPTERCLIENT=Target%1Client
    )
    if "%2" EQU "server" (
	set MPC_ADAPTERSERVER=Target%1Server
    )
    set MPC_TI_DLL_EXE=dll_exe:msvc90-exe-generic+ace+tao
    set MPC_TI_DLL=dll:msvc90-dll-generic+ace+tao
    set MPC_TI_LIB=lib:msvc90-lib-generic+ace+tao
   
    W:
    cd "%MPC_PROJECTS%"

    if "%MPC_ADAPTERCLIENT%" NEQ "" (
    	perl "%MPC_EXEC%" -include "%MPC_TMPL%" -type "%MPC_TYPE%" -ti "%MPC_TI_DLL_EXE%" -ti "%MPC_TI_DLL%" -ti "%MPC_TI_LIB%" "./targets/%MPC_ADAPTERCLIENT%.mpc"
    	echo Running fix script using ./fixes/%MPC_ADAPTERCLIENT%.vcproj-fix.pl
    	perl "./fixes/%MPC_ADAPTERCLIENT%.vcproj-fix.pl"
    )
    if "%MPC_ADAPTERSERVER%" NEQ "" (
	echo %MPC_ADAPTERSERVER%
    	perl "%MPC_EXEC%" -include "%MPC_TMPL%" -type "%MPC_TYPE%" -ti "%MPC_TI_DLL_EXE%" -ti "%MPC_TI_DLL%" -ti "%MPC_TI_LIB%" "./targets/%MPC_ADAPTERSERVER%.mpc"
    	echo Running fix script using ./fixes/%MPC_ADAPTERSERVER%.vcproj-fix.pl
    	perl "./fixes/%MPC_ADAPTERSERVER%.vcproj-fix.pl"
    )

  :main.end

:: } GARANT
@endlocal & exit /b

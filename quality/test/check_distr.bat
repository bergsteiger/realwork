rem **********************************************************************
rem ********* Скрипт для проверки правильности работы инсталляторов ******
rem **********************************************************************
rem Запускается из директории, в которой установлен Гарант.
rem chesk.bat <RUS/ENG> <LOCDOS/LOCWIN/ONE/NET/LOCDIC/DIC> 
rem где:
rem <RUS/ENG> - Русский\Английский инсталлятор 
rem <LOCDOS/LOCWIN/ONE/NET/LOCDIC/DIC> - Локальная для DOS\Локальная для Windows без Словаря\Однопользовательская
rem \Сетевая\Локальная для Windows со Словарем\Только Словарь 
rem **********************************************************************
rem ******* Имя пользователя = Кампания = Серийный номер = test **********
rem **********************************************************************
:begin
fc /b \\developer\garant\develop.52\bin\mirror\TOOLS\BASEINFO.EXE tools\baseinfo.exe >tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\CWSDPMI.EXE tools\cwsdpmi.exe >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\DONGLE.DLL tools\dongle.dll >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\EVFN.COM tools\evfn.com >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\GL.EXE tools\gl.exe >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\GLW.EXE tools\glw.exe >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\GU.EXE tools\gu.exe >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\GU717.DLL tools\gu717.dll >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\GUW32.EXE tools\guw32.exe >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\IMPFB.EXE tools\impfb.exe >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\KEYDISK.EXE tools\keydisk.exe >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\MFC42.DLL tools\mfc42.dll >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\UNZDLL.DLL tools\unzdll.dll >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\UNZIP.EXE tools\unzip.exe >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\UPDATE.CNT tools\update.cnt >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\UPDATE.EXE tools\update.exe >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\UPDATE.GID tools\update.gid >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\UPDATE.HLP tools\update.hlp >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\UPDATE.ICO tools\update.ico >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\UPDATE16.PIF tools\update16.pif >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\UPDATE.RES tools\update.res >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\UPDATE16.EXE tools\update16.exe >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\UPD_DIAG.EXE tools\UPD_DIAG.EXE >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\VENIK.EXE tools\VENIK.EXE >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\WBASEINF.EXE tools\WBASEINF.EXE >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\download.EXE tools\download.EXE >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\download.hlp tools\download.hlp >>tools.txt
if %1==RUS fc /b \\developer\garant\develop.52\bin\mirror\tools\BREEDR32.EXE tools\BREEDR32.EXE >>tools.txt
if %1==ENG fc /b \\developer\garant\develop.52\bin\mirror\tools_eng\BREEDR32.EXE tools\BREEDR32.EXE >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\GL.DLL tools\GL.DLL >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\BREEDER.RES tools\BREEDER.RES >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\KEYDISK.PIF tools\KEYDISK.PIF >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\BREEDR32.HLP tools\BREEDR32.HLP >>tools.txt
fc /b \\developer\garant\develop.52\bin\mirror\tools\BIND.EXE tools\BIND.EXE >>tools.txt

:two
if %2==LOCWIN goto locwin
if %2==LOCDOS goto locdos
if %2==ONE goto one
if %2==NET goto net
if %2==LOCDIC goto locdic
if %2==DIC goto dic
echo WRONG SECOND PHARAMETER
goto end

:locwin
fc /b \\developer\garant\develop.52\bin\mirror\shell.win\*.* shell.win\*.* >shellwin.txt
fc /b \\developer\garant\develop.52\bin\mirror\garwinos.exe garwinos.exe >root.txt
if %1==ENG fc /b \\developer\garant\develop.52\bin\mirror\tools_eng\version.rps version.rps >>root.txt
if %1==RUS fc /b \\developer\garant\develop.52\bin\mirror\version.rps version.rps >>root.txt
goto fonts

:locdos
fc /b \\developer\garant\develop.52\bin\mirror\shell.dos\*.* shell.dos\*.* >shelldos.txt
fc /b \\developer\garant\develop.52\bin\mirror\garant4.exe garant4.exe >root.txt
if %1==ENG fc /b \\developer\garant\develop.52\bin\mirror\tools_eng\version.rps version.rps >>root.txt
if %1==RUS fc /b \\developer\garant\develop.52\bin\mirror\version.rps version.rps >>root.txt
goto end

:one
:net
fc /b \\developer\garant\develop.52\bin\mirror\shell.win\*.* shell.win\*.* >shellwin.txt
fc /b \\developer\garant\develop.52\bin\mirror\garwinos.exe garwinos.exe >root.txt
if %1==ENG fc /b \\developer\garant\develop.52\bin\mirror\tools_eng\version.rps version.rps >>root.txt
if %1==RUS fc /b \\developer\garant\develop.52\bin\mirror\version.rps version.rps >>root.txt
fc /b \\developer\garant\develop.52\bin\mirror\shell.dos\*.* shell.dos\*.* >shelldos.txt
fc /b \\developer\garant\develop.52\bin\mirror\garant4.exe garant4.exe >>root.txt
fc /b \\developer\garant\develop.52\bin\mirror\windic32.exe windic32.exe >>root.txt
fc /b \\developer\garant\develop.52\bin\mirror\shell.dic\*.* shell.dic\*.* >shelldic.txt
fc /b \\developer\garant\develop.52\bin\mirror\shell.dic\tools\*.* shell.dic\tools\*.* >toolsdic.txt 
goto fonts

:locdic
fc /b \\developer\garant\develop.52\bin\mirror\shell.win\*.* shell.win\*.* >shellwin.txt
fc /b \\developer\garant\develop.52\bin\mirror\garwinos.exe garwinos.exe >root.txt
if %1==ENG fc /b \\developer\garant\develop.52\bin\mirror\tools_eng\version.rps version.rps >>root.txt
if %1==RUS fc /b \\developer\garant\develop.52\bin\mirror\version.rps version.rps >>root.txt
fc /b \\developer\garant\develop.52\bin\mirror\shell.dic\*.* shell.dic\*.* >shelldic.txt
fc /b \\developer\garant\develop.52\bin\mirror\windic32.exe windic32.exe >>root.txt
fc /b \\developer\garant\develop.52\bin\mirror\shell.dic\tools\*.* shell.dic\tools\*.* >toolsdic.txt 
goto fonts

:dic
fc /b \\developer\garant\develop.52\bin\mirror\shell.dic\*.* shell.dic\*.* >shelldic.txt
fc /b \\developer\garant\develop.52\bin\mirror\shell.dic\tools\*.* shell.dic\tools\*.* >toolsdic.txt 
fc /b \\developer\garant\develop.52\bin\mirror\windic32.exe windic32.exe >root.txt
if %1==ENG fc /b \\developer\garant\develop.52\bin\mirror\tools_eng\version.rps version.rps >>root.txt
if %1==RUS fc /b \\developer\garant\develop.52\bin\mirror\version.rps version.rps >>root.txt
goto end

:fonts
fc /b \\developer\garant\develop.52\bin\mirror\shell.win\fonts\*.* shell.win\fonts\*.* >fonts.txt
goto end 

:end
	
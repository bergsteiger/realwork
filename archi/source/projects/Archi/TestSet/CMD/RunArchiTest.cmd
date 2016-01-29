taskkill /F /IM ArchiTest.exe

del ArchiTest_*.out
del ArchiTest_*.txt
del ArchiTest.clog
del ArchiTest.log

REM Чистим директорию TestSet или создаем её, если нет.
powershell -File ClearTestSet.ps1

REM Устанавливаем принтер по умолчанию.
powershell -File SetDefaultPrinterEX.ps1

if "%1"=="daily" (
 if EXIST ArchiTest.exe (
  del ArchiTest_bak.exe
  del ArchiTest_bak.map
  ren ArchiTest.exe ArchiTest_bak.exe  
  ren ArchiTest.map ArchiTest_bak.map    
 )  
 copy k:\!TESTS\ArchiTest\ArchiTest.exe w:\binout\Archi\
 copy k:\!TESTS\ArchiTest\ArchiTest.map w:\binout\Archi\
 if NOT EXIST ArchiTest.exe (
  ren ArchiTest_bak.exe ArchiTest.exe  
  ren ArchiTest_bak.map ArchiTest.map 
 )  
)
call ClearCopyBase.cmd
start "" arun.exe

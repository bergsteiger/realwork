taskkill /F /IM EverestLiteTest.exe

del EverestLiteTest_*.out
del EverestLiteTest_*.txt
del EverestLiteTest.clog
del EverestLiteTest.log

REM Чистим директорию TestSet или создаем её, если нет.
powershell -File ClearTestSet.ps1

REM Устанавливаем принтер по умолчанию.
powershell -File SetDefaultPrinterEX.ps1

if "%1"=="daily" (
 if EXIST EverestLiteTest.exe (
  del EverestLiteTest_bak.exe
  del EverestLiteTest_bak.map
  ren EverestLiteTest.exe EverestLiteTest_bak.exe  
  ren EverestLiteTest.map EverestLiteTest_bak.map    
 )  
 if EXIST everest2everest.exe (
  del everest2everest_bak.exe
  del everest2everest_bak.map
  ren everest2everest.exe everest2everest_bak.exe
  ren everest2everest.map everest2everest_bak.map
 )  
 copy k:\!TESTS\everest2everest\everest2everest.exe w:\binout\exe\1.2\
 copy k:\!TESTS\everest2everest\everest2everest.map w:\binout\exe\1.2\
 copy k:\!TESTS\EverestLiteTest\EverestLiteTest.exe w:\binout\exe\1.2\
 copy k:\!TESTS\EverestLiteTest\EverestLiteTest.map w:\binout\exe\1.2\
 if NOT EXIST EverestLiteTest.exe (
  ren EverestLiteTest_bak.exe EverestLiteTest.exe
  ren EverestLiteTest_bak.map EverestLiteTest.map
 )  
 if NOT EXIST everest2everest.exe (
  ren everest2everest_bak.exe everest2everest.exe
  ren everest2everest_bak.map everest2everest.map
 )  
)

start "" EverestLiteTest.exe -toK
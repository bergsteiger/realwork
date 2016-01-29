echo off
rmdir /q /s C:\works\webTesting\TC7\TestPrj\IntranetSuite\Intranet\Log\
mkdir C:\works\webTesting\TC7\TestPrj\IntranetSuite\Intranet\Log
for /F %%i in (comp.lst) do (  
  xcopy /y /s C:\works\webTesting\TC7 \\%%i\c$\TestStand\TC7\
)


SET ADDR=inet:localhost:12000

REM start server -ORBIIOPAddr %ADDR%

pause 1

client -ORBBindAddr %ADDR%

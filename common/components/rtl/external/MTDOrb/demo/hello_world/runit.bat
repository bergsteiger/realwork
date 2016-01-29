SET ADDR=inet:localhost:12000

start server -ORBIIOPAddr %ADDR%

pause 1

client -ORBBindAddr %ADDR%

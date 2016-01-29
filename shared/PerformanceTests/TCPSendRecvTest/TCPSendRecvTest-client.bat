@echo off

call "TCPSendRecvTest-common.bat"

set $COMMANDLINE=-c -p "%PORT%"

:: set ACE_RECV_MAX_SOCKET_BUFSIZ=%ACE_DEFAULT_MAX_SOCKET_BUFSIZ%
:: set ACE_SEND_MAX_SOCKET_BUFSIZ=%ACE_DEFAULT_MAX_SOCKET_BUFSIZ%

:: set ACE_LARGE_DATA_RECV_ENABLED=1
:: set ACE_LARGE_DATA_SEND_ENABLED=1

if not "%OS%"=="Windows_NT" ".\win9X\TCPSendRecvTest" %$COMMANDLINE% "%HOST%"
if     "%OS%"=="Windows_NT" ".\winNT\TCPSendRecvTest" %$COMMANDLINE% "%HOST%"

exit /b

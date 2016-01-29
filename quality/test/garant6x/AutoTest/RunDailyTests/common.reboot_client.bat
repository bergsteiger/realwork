rem Батник для перезагрузки хоста

rem Посылаем сообщение серверу перегрузиться
%PS_TOOLS_PATH%\psshutdown.exe -r -f -t 1
exit
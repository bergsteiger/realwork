REM Останавливаем сервер
"C:\Garant\apps\winNT\F1ServerStopper.exe" -GCMConfigFile "C:\Garant\garant.ini" -GPMAdapterConfigSection "F1Client Params" %*

REM Спим 40 секунд, т.к. сервер может останавливаться и выгружать пользователей 30 сек. + 10 секунд запас
sleep 40

REM Снятие задачи Visual Studio
pskill.exe msdev.exe

REM !!!СЮДА Добавить код прописывания лицензии!!!

REM Запуск Visual Studio и выполнение функции Main из макроса, проинсталлированного в VS
msdev W:\garant6x\implementation\Garant\GblAdapter\gbladapter.dsw -ex StartF1Server
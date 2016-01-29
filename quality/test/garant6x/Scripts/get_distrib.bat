@echo off
REM Данный скрипт копирует дистрибутив Гаранта из destination в source

REM путь откуда забирать дистрибутив
SET destination=\\developer\garant-nemesis\deployment

REM путь куда будем копировать
SET source=E:\works

REM читаем тэг из файла !cvs_tag и создаём папку с именем тэга
if exist "%destination%\!daily\!cvs_tag" FOR /F "eol=; delims=*" %%i in (%destination%\!daily\!cvs_tag) do SET source=%source%\%%i
if not exist %source% mkdir %source%

REM Создаём по пути source  папки !daily и !daily-installer
if exist "%source%\!daily" del /q /f /s "%source%\!daily"
if exist "%source%\!daily-installer" del /q /f /s "%source%\!daily-installer"

mkdir "%source%\!daily"
mkdir "%source%\!daily-installer"

REM копируем папку !daily
xcopy "%destination%\!daily" "%source%\!daily" /y /r /e

REM копируем папку !daily-installer
xcopy "%destination%\!daily-installer" "%source%\!daily-installer" /y /r /e


REM **********************************************************************************************************************

REM путь куда будем копировать
SET source=E:\works

REM читаем тэг из файла !cvs_tag и создаём папку с именем тэга
if exist "%destination%\!daily-6.2\!cvs_tag" FOR /F "eol=; delims=*" %%i in (%destination%\!daily-6.2\!cvs_tag) do SET source=%source%\%%i
if not exist %source% mkdir %source%

REM Создаём по пути source  папки !daily и !daily-installer
if exist "%source%\!daily-6.2" del /q /f /s "%source%\!daily-6.2"
if exist "%source%\!daily-installer-6.2" del /q /f /s "%source%\!daily-installer-6.2"

mkdir "%source%\!daily-6.2"
mkdir "%source%\!daily-installer-6.2"

REM копируем папку !daily-6.2
xcopy "%destination%\!daily-6.2" "%source%\!daily-6.2" /y /r /e

REM копируем папку !daily-installer-6.2
xcopy "%destination%\!daily-installer-6.2" "%source%\!daily-installer-6.2" /y /r /e
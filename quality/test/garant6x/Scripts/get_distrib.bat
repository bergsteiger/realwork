@echo off
REM ����� �ਯ� ������� ����ਡ�⨢ ��࠭� �� destination � source

REM ���� ��㤠 ������� ����ਡ�⨢
SET destination=\\developer\garant-nemesis\deployment

REM ���� �㤠 �㤥� ����஢���
SET source=E:\works

REM �⠥� �� �� 䠩�� !cvs_tag � ᮧ��� ����� � ������ ��
if exist "%destination%\!daily\!cvs_tag" FOR /F "eol=; delims=*" %%i in (%destination%\!daily\!cvs_tag) do SET source=%source%\%%i
if not exist %source% mkdir %source%

REM ������ �� ��� source  ����� !daily � !daily-installer
if exist "%source%\!daily" del /q /f /s "%source%\!daily"
if exist "%source%\!daily-installer" del /q /f /s "%source%\!daily-installer"

mkdir "%source%\!daily"
mkdir "%source%\!daily-installer"

REM �����㥬 ����� !daily
xcopy "%destination%\!daily" "%source%\!daily" /y /r /e

REM �����㥬 ����� !daily-installer
xcopy "%destination%\!daily-installer" "%source%\!daily-installer" /y /r /e


REM **********************************************************************************************************************

REM ���� �㤠 �㤥� ����஢���
SET source=E:\works

REM �⠥� �� �� 䠩�� !cvs_tag � ᮧ��� ����� � ������ ��
if exist "%destination%\!daily-6.2\!cvs_tag" FOR /F "eol=; delims=*" %%i in (%destination%\!daily-6.2\!cvs_tag) do SET source=%source%\%%i
if not exist %source% mkdir %source%

REM ������ �� ��� source  ����� !daily � !daily-installer
if exist "%source%\!daily-6.2" del /q /f /s "%source%\!daily-6.2"
if exist "%source%\!daily-installer-6.2" del /q /f /s "%source%\!daily-installer-6.2"

mkdir "%source%\!daily-6.2"
mkdir "%source%\!daily-installer-6.2"

REM �����㥬 ����� !daily-6.2
xcopy "%destination%\!daily-6.2" "%source%\!daily-6.2" /y /r /e

REM �����㥬 ����� !daily-installer-6.2
xcopy "%destination%\!daily-installer-6.2" "%source%\!daily-installer-6.2" /y /r /e
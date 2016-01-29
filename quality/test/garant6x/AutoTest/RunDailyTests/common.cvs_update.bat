rem Update файлов из CVS
rem Для работы необходимо, чтобы была задана переменная окружения CVSROOT и
rem был происан путь к каталогу где установлен CVS (конкретнее - нужен путь к файлу cvs.exe)

rem Определяем каталог где лежат файлы CVS и пути к каталогам, которые собираемся обновлять

SET CURRENT_DISK=%~d0
SET CURRENT_PATH=%~dp0
SET DESTINATION_DISK=W:
SET CVS_DIR=W:
SET CVS_UPDATE_LOG=%CVS_DIR%\cvs_update.log
SET CVS_UPD_PATH_01=%CVS_DIR%\quality\test\garant6x\AutoTest\RunDailyTests
SET CVS_UPD_PATH_02=%CVS_DIR%\quality\test\garant6x\implementation
rem SET CVS_BRANCH_PARAM=-r B_TEST_COMPLETE_3

rem %9 Параметры рассылки почты
SET NETWORK_DRIVE=C:\WORKS
SET BLAT_PATH=%NETWORK_DRIVE%\.EXTERNAL\blat
SET MAIL_TO=qc@garant.ru
SET MAIL_FROM=AutoTest@garant.ru
SET SMTP_SRV=smtp.garant.ru

rem Переходим в каталог который собираемся обновить и запускаем update данного каталога
%DESTINATION_DISK%
@ECHO CVS UPDATE ON %COMPUTERNAME%
cd %CVS_UPD_PATH_01%
cvs update -P -d -C 1>%CVS_UPDATE_LOG% 2>&1
cd %CVS_UPD_PATH_02%
cvs update -P -d -C 1>>%CVS_UPDATE_LOG% 2>>&1
%CURRENT_DISK%
cd %CURRENT_PATH%

rem Высылаем лог результатов апдэйта
%BLAT_PATH%\blat -install %SMTP_SRV% %MAIL_FROM%
%BLAT_PATH%\blat %CVS_DIR%\cvs_update.log -charset windows-1251 -subject "AutoTest: %COMPUTERNAME% CVS update log" -to %MAIL_TO%
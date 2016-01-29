:send_mail_begin
REM Отправляем письмо

set MAIL_FROM=reminder@garant.ru
set MAIL_TO=qc@garant.ru

set MAIL_CHARSET=windows-1251
set MAIL_REPLYTO=%MAIL_TO%
set MAIL_SERVER=smtp.garant.ru

blat.exe "remind_consulting.txt" -charset "%MAIL_CHARSET%" -f "%MAIL_FROM%" -priority "1" -replyto "%MAIL_REPLYTO%" -server "%MAIL_SERVER%" -subject "+!новый способ запуска! Необходимо проверить работу консультаций." -to "%MAIL_TO%" 1>nul 2>&1
:send_mail_end
rem Сетевой ресурс с проектами и внешними утилитами
rem должен быть подключен как диск R: (\\p3single05\works)
rem Проверяем подключен ли сетевой диск
IF NOT EXIST R:\.SUPPORT GOTO not_connected
GOTO connected

:not_connected
net use R: /DELETE /Y
net use R: \\10.14.3.214\works2
:connected

R:\.PERFOMANCE\quality\test\garant6x\AutoTest\RunDailyTests\start_daily_test.%COMPUTERNAME%.bat %1
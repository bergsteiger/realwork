rem ��⥢�� ����� � �஥�⠬� � ���譨�� �⨫�⠬�
rem ������ ���� ������祭 ��� ��� R: (\\p3single05\works)
rem �஢��塞 ������祭 �� �⥢�� ���
IF NOT EXIST R:\.SUPPORT GOTO not_connected
GOTO connected

:not_connected
net use R: /DELETE /Y
net use R: \\10.14.3.214\works2
:connected

R:\.PERFOMANCE\quality\test\garant6x\AutoTest\RunDailyTests\start_daily_test.%COMPUTERNAME%.bat %1
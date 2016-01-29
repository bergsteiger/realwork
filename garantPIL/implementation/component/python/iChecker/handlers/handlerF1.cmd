@echo off

@echo [%date% %time%] F1 is down. Trying to restart F1 and all Web services. >> logs/%1.log 

@python serviceHelper.py --action=stopWeb --port_data=%4 --port_web=%5 >> logs/%1.log
@python serviceHelper.py --action=stopData --port_data=%4 --port_web=%5 >> logs/%1.log

@echo Delete settings and copy clear >> logs/%1.log
@del /S /Q "%~2\settings\*.*" >> logs/%1.log
@xcopy /Y /E /F "%~2\recovery\settings\*.*" "%~2\settings" >> logs/%1.log

@python serviceHelper.py --action=startData --port_data=%4 --port_web=%5 >> logs/%1.log
@python serviceHelper.py --action=startWeb --port_data=%4 --port_web=%5 >> logs/%1.log
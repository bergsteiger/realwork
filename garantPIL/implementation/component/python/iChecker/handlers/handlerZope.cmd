@echo off

@echo [%date% %time%] Web is down. Trying to restart. >> logs/%1.log

python serviceHelper.py --action=stopWeb --port_data=%4 --port_web=%5 >> logs/%1.log
python serviceHelper.py --action=startWeb --port_data=%4 --port_web=%5 >> logs/%1.log
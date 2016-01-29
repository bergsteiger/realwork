SET JOURNAL_FILE=journal.test
@echo START_TEST >%JOURNAL_FILE%
call 00.Main_Run_All_Autotest.bat

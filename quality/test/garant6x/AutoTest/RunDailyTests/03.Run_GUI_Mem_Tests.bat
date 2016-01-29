rem	Измерение потребления памяти в зависимости от различных действий

rem	Возможные операции (mem_test_op):
rem 		Открытие_документов
rem		Открытие_списков
rem		Поиски_по_ППР
rem		Поиски_по_ППР_1_контекст
rem		Логин_логаут_одним_пользователем


rem ***************************************************************************

rem	****** Открытие документов ******

rem	Ставим чистые настройки
call common.do_clean_settings.bat

rem Пускаем тест
%TC_PATH% /run /project:MemoryUsing /unit:MemoryUsing /routine:Main /exit /SilentMode "%TC_PROJECT_PATH%\memoryusing.mds" ps_tools_path=%PS_TOOLS_PATH% mem_test_op=Открытие_документов iter_count=350

rem 	****** Поиски по ППР ******

rem	Ставим чистые настройки
call common.do_clean_settings.bat

rem Ставим определенные настройки
rem

rem Пускаем тест
%TC_PATH% /run /project:MemoryUsing /unit:MemoryUsing /routine:Main /exit /SilentMode "%TC_PROJECT_PATH%\memoryusing.mds" ps_tools_path=%PS_TOOLS_PATH% mem_test_op=Поиски_по_ППР iter_count=70

rem 	****** Поиски по ППР с одним контекстом ******

rem	Ставим чистые настройки
call common.do_clean_settings.bat

rem Ставим определенные настройки
rem

rem Пускаем тест
%TC_PATH% /run /project:MemoryUsing /unit:MemoryUsing /routine:Main /exit /SilentMode "%TC_PROJECT_PATH%\memoryusing.mds" ps_tools_path=%PS_TOOLS_PATH% mem_test_op=Поиски_по_ППР_1_контекст iter_count=50

rem 	****** Логин/логаут 1 пользователем ******

rem	Ставим чистые настройки
call common.do_clean_settings.bat

rem Пускаем тест
%TC_PATH% /run /project:MemoryUsing /unit:MemoryUsing /routine:Main /exit /SilentMode "%TC_PROJECT_PATH%\memoryusing.mds" ps_tools_path=%PS_TOOLS_PATH% mem_test_op=Логин_логаут_одним_пользователем iter_count=50

rem 	****** Открытие списков ******

rem	Ставим чистые настройки
call common.do_clean_settings.bat

rem Пускаем тест
%TC_PATH% /run /project:MemoryUsing /unit:MemoryUsing /routine:Main /exit /SilentMode "%TC_PROJECT_PATH%\memoryusing.mds" ps_tools_path=%PS_TOOLS_PATH% mem_test_op=Открытие_списков iter_count=200

rem 	****** Высылаем логи ******

%TC_PATH% /run /project:MemoryUsing /unit:MemoryUsing /routine:Main /exit /SilentMode "%TC_PROJECT_PATH%\memoryusing.mds" ps_tools_path=%PS_TOOLS_PATH% mem_test_op=Выслать_логи
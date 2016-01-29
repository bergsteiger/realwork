@echo off

rem Управляющие
	rem тестовый режим
set IS_TEST_MODE=OFF
	rem запускать тесты сначала на одной машине, затем на другой и т.д. или параллельно
set IS_START_COMP_BY_COMP=OFF
	rem имя файла со сценарием для тестов
set SCENARIO_FILE_NAME=scenario2.xml
	rem задержка между запуском клиентов на удаленных машинах
set SLEEP_TIME=0&
	rem имя файла со списком удаленных машин
set COMPS_LIST=comps.lst

rem Общие
	rem имя пользователя, с которым будем логинится на удаленные машины
set USER_NAME=qc
	rem пароль пользователя, с именем которого будем логиниться на удаленные машины
set PASSWORD=22222
	rem путь к утилитам pstools
set PSTOOLS_PATH=\\strelka\qc\RemoteAdapterTest\PsTools
	rem сетевой путь к корневой папке с тестами и батниками
set NETWORK_PATH=\\strelka.garant.ru\qc\RemoteAdapterTest
	rem параметры, с которыми будет запускаться команда start, запускающая psexec/pstools/pslist/тесты
set START_PARAMS=/MIN /BELOWNORMAL

rem Вспомогательные
	rem путь к папке с управляющими батниками (данные батники)
set CONTROL_NETWORK_PATH=%NETWORK_PATH%\ControlScripts
	rem путь к папке с тестами
set AT_NETWORK_PATH=%NETWORK_PATH%\AdapterTest
	rem путь к файлу со сценарием
set SCENARIO_FILE_PATH=%AT_NETWORK_PATH%\%SCENARIO_FILE_NAME%
	rem путь к утилите sleep.exe
set SLEEP_EXE=%AT_NETWORK_PATH%\sleep.exe
	rem общие параметры для всех утилит pstool
set PSTOOLS_COMMON_PARAMS=-accepteula&
	rem имя файла консольного теста без расширения
set TEST_NAME=F1AdapterTest&


if not exist "%SCENARIO_FILE_PATH%" (
	echo Файл сценария не существует!
	exit 1
)


if "%IS_TEST_MODE%" equ "ON" (
	set START=echo
) else if "%IS_TEST_MODE%" equ "OFF" (
	set START=start
) else (
	echo Неизвестное значение IS_TEST_MODE ^(%IS_TEST_MODE%^)
	exit 1
)


if "%IS_START_COMP_BY_COMP%" equ "ON" (
	set START_WAIT_PARAM=/WAIT
) else if "%IS_START_COMP_BY_COMP%" equ "OFF" (
	set START_WAIT_PARAM=
) else (
	echo Неизвестное значение IS_START_COMP_BY_COMP ^(%IS_START_COMP_BY_COMP%^)
	exit 1
)
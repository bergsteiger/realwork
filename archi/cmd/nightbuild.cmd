@echo off
title ARCHI group nightbuild script
SET BUILDROOT=X:\NIGHTBUILD

rem goto copying

set CVSROOT=:pserver:fireton@cvs.garant.ru:/cvs
call cvs_get.cmd %1
rem call cvs_bydate.cmd
rem goto build
rem pause
:build

mkdir M:\out\units
mkdir M:\out\exe

rem Готовим начальный файл опций для мейлера
echo -server smtp.garant.ru > M:\out\mailopt.txt
echo -f archi@garant.ru >> M:\out\mailopt.txt
echo -to supportarchi@garant.ru >> M:\out\mailopt.txt
echo -charset windows-1251 >> M:\out\mailopt.txt

rem инкрементируем номер сборки
incbuild.exe
call setbuildno.cmd

rem Начинаем сборку
echo Сборка %BUILDNO% началась %DATE% %TIME% > M:\out\exe\build.log
echo. >> M:\out\exe\build.log
call W:\build_scripts\confbuild.bat "start" "archi" "fakeTag" "%BUILDNO%" "0" ""

rem goto dailytest

rem archi
call versioninfo.cmd Archi W:\archi\source\projects\archi
call buildone.cmd Archi W:\archi\source\projects\archi

rem  archi_old
rem pushd W:\common\components\gui\Garant\Everest
rem cvs -q update -P -r B_archi_old_everest 
rem popd
rem call buildone.cmd Archi W:\archi\source\projects\archi Archi_OldEverest
rem pushd W:\common\components\gui\Garant\Everest
rem cvs -q update -P -A -d -C
rem popd

rem exit /b

rem AutoPipeServer
call versioninfo.cmd AutoPipeServer W:\archi\source\projects\PipeInAuto
call buildone.cmd AutoPipeServer W:\archi\source\projects\PipeInAuto PipeInAuto_GARANT NB_NPP
call buildone.cmd AutoPipeServer W:\archi\source\projects\PipeInAuto PipeInAuto_AAC NB_AAC
call buildone.cmd AutoPipeServer W:\archi\source\projects\PipeInAuto PipeInAuto_LUK NB_LUK
call buildone.cmd AutoPipeServer W:\archi\source\projects\PipeInAuto PipeInAuto_REGION NB_REGION
call buildone.cmd AutoPipeServer W:\archi\source\projects\PipeInAuto PipeInAuto_INDEXER NB_INDEXER

rem alcuTaskExecutor
call versioninfo.cmd alcuTaskExecutor W:\archi\source\projects\PipeInAuto\Assistant
call buildone.cmd alcuTaskExecutor W:\archi\source\projects\PipeInAuto\Assistant alcuTaskExecutor_GARANT NB_NPP
call buildone.cmd alcuTaskExecutor W:\archi\source\projects\PipeInAuto\Assistant alcuTaskExecutor_AAC NB_AAC
call buildone.cmd alcuTaskExecutor W:\archi\source\projects\PipeInAuto\Assistant alcuTaskExecutor_LUK NB_LUK
call buildone.cmd alcuTaskExecutor W:\archi\source\projects\PipeInAuto\Assistant alcuTaskExecutor_REGION NB_REGION
call buildone.cmd alcuTaskExecutor W:\archi\source\projects\PipeInAuto\Assistant alcuTaskExecutor_INDEXER NB_INDEXER

:mdpsync
rem mdpSyncPrj
rem call versioninfo.cmd mdpSyncPrj W:\archi\source\projects\PipeInAuto\MDPSync
rem call buildone.cmd mdpSyncPrj W:\archi\source\projects\PipeInAuto\MDPSync

rem goto buildend

rem archi test
call versioninfo.cmd ArchiTest W:\archi\source\projects\archi
call buildone.cmd ArchiTest W:\archi\source\projects\archi

rem CreateTestBase
call versioninfo.cmd CreateTestBase W:\archi\source\projects\Tools\CreateTestBase
call buildone.cmd CreateTestBase W:\archi\source\projects\Tools\CreateTestBase

rem EverestLite
call versioninfo.cmd EverestLite W:\archi\source\projects\Everest\Lite\7.0\Express
call buildone.cmd EverestLite W:\archi\source\projects\Everest\Lite\7.0\Express
call buildone.cmd EverestLite W:\archi\source\projects\Everest\Lite\7.0\Express EverestLite_AMD NB_AMD
call buildone.cmd EverestLiteTest W:\archi\source\projects\Everest\Lite\7.0\Express

rem Everest
call versioninfo.cmd Everest W:\archi\source\projects\Everest\7.0
call buildone.cmd Everest W:\archi\source\projects\Everest\7.0

rem PipeOut2
call versioninfo.cmd PipeOut2 W:\archi\source\projects\PipeOut
call buildone.cmd PipeOut2 W:\archi\source\projects\PipeOut

rem NSRCSPY
call versioninfo.cmd NSRCSPY W:\archi\source\projects\PipeIn
call buildone.cmd NSRCSPY W:\archi\source\projects\PipeIn

rem AddImg
call versioninfo.cmd AddImg W:\archi\source\projects\db\AddImg
call buildone.cmd AddImg W:\archi\source\projects\db\AddImg

rem DbUtil
call versioninfo.cmd DbUtil W:\archi\source\projects\db\DbUtil
call buildone.cmd DbUtil W:\archi\source\projects\db\DbUtil

rem AdjustToPage
call versioninfo.cmd AdjustToPage W:\archi\source\projects\Tools\AdjustToPage
call buildone.cmd AdjustToPage W:\archi\source\projects\Tools\AdjustToPage

rem nsrplus2nsr
call versioninfo.cmd nsrplus2nsr W:\archi\source\projects\Converters\NsrPlus2nsr
call buildone.cmd nsrplus2nsr W:\archi\source\projects\Converters\NsrPlus2nsr

rem nsrc2everest
call versioninfo.cmd nsrc2everest W:\archi\source\projects\Converters\nsrc2everest
call buildone.cmd nsrc2everest W:\archi\source\projects\Converters\nsrc2everest

rem everest2nsrc
call versioninfo.cmd everest2nsrc W:\archi\source\projects\Converters\Everest2nsrc
call buildone.cmd everest2nsrc W:\archi\source\projects\Converters\Everest2nsrc

rem html2evd
call versioninfo.cmd html2evd W:\archi\source\projects\Converters\html2evd
call buildone.cmd html2evd W:\archi\source\projects\Converters\html2evd

rem evd2html
call versioninfo.cmd evd2html W:\archi\source\projects\Converters\evd2html
call buildone.cmd evd2html W:\archi\source\projects\Converters\evd2html

rem regiontool
call versioninfo.cmd regiontool W:\archi\source\projects\db\regiontool
call buildone.cmd regiontool W:\archi\source\projects\db\regiontool

rem DbUpdate64
call versioninfo.cmd DbUpdate64 W:\archi\source\projects\db\updating
call buildone.cmd DbUpdate64 W:\archi\source\projects\db\updating

rem DictSync
call versioninfo.cmd DictSync W:\archi\source\projects\db\DictSync
call buildone.cmd DictSync W:\archi\source\projects\db\DictSync

rem everest2everest
call versioninfo.cmd everest2everest W:\archi\source\projects\Converters\Everest2Everest
call buildone.cmd everest2everest W:\archi\source\projects\Converters\Everest2Everest

rem gm
call versioninfo.cmd gm W:\archi\source\projects\Tools\GetVersion
call buildone.cmd gm W:\archi\source\projects\Tools\GetVersion

rem gv
call versioninfo.cmd gv W:\archi\source\projects\Tools\GetVersion
call buildone.cmd gv W:\archi\source\projects\Tools\GetVersion

rem TextCalc
call versioninfo.cmd TextCalc W:\archi\source\projects\TextCalc
call buildone.cmd TextCalc W:\archi\source\projects\TextCalc

rem listimport
call versioninfo.cmd listimport W:\archi\source\projects\Tools\listimport
call buildone.cmd listimport W:\archi\source\projects\Tools\listimport

rem gzPrj
call versioninfo.cmd gzPrj W:\archi\source\projects\Converters\gzPrj
call buildone.cmd gzPrj W:\archi\source\projects\Converters\gzPrj

rem ClearClass
call versioninfo.cmd ClearClass W:\archi\source\projects\Tools\ClearClass
call buildone.cmd ClearClass W:\archi\source\projects\Tools\ClearClass

rem Obam
call versioninfo.cmd Obam W:\archi\source\projects\Tools\Obam
call buildone.cmd Obam W:\archi\source\projects\Tools\Obam

rem Obam
call versioninfo.cmd impchdate W:\archi\source\projects\Tools\ImportChDateDocs
call buildone.cmd impchdate W:\archi\source\projects\Tools\ImportChDateDocs

rem stg32
call buildone.cmd stg32 W:\common\components\stg32

:dailytest
rem DailyTest
call buildone.cmd DailyTest W:\common\components\DailyTest
rem exit /B

pushd W:\common\components\gui\Garant\VCM
if "%CVSDATE%" == "" (
 cvs -q update -P -d -r B_Before_No_Module_Internal 
) else (
 cvs -q update -P -d -r B_Before_No_Module_Internal -D "%CVSDATE%"
)
popd

rem  admin2
call versioninfo.cmd admin2 W:\archi\source\projects\Admin2
call buildone.cmd admin2 W:\archi\source\projects\Admin2
call buildone.cmd admin2 W:\archi\source\projects\Admin2 Admin2_FAS NB_FAS

:buildend
echo. >> M:\out\exe\build.log
echo Сборка завершена %DATE% %TIME% >> M:\out\exe\build.log

rem Проверяем результаты сборки и отправляем письмо
if EXIST M:\out\errors.txt (
 echo -subject "Автоматическая сборка завершилась с ошибками!" >> M:\out\mailopt.txt
 echo -priority 1 >> M:\out\mailopt.txt
 echo -bodyF "M:\\out\\errors.txt" >> M:\out\mailopt.txt
 call W:\build_scripts\confbuild.bat "failure" "archi" "fakeTag" "%BUILDNO%" "0" "" "%BUILDROOT%\env\out\conf_log.txt"
) ELSE (
 echo -subject "Автоматическая сборка завершилась успешно" >> M:\out\mailopt.txt
 echo -body "Все проекты были успешно собраны." >> M:\out\mailopt.txt
 call W:\build_scripts\confbuild.bat "done" "archi" "fakeTag" "%BUILDNO%" "0" ""
)
blat - -of "M:\out\mailopt.txt"
del M:\out\mailopt.txt
del M:\out\errors.txt
del M:\out\conf_log.txt

subst W: /D
subst M: /D

rem subst W: C:\work\cvs
rem subst M: C:\work

:copying

rem Копируем тесты для Димы Инишева

echo net use > %BUILDROOT%\nblog.txt
net use S: \\archi\archi /USER:PU\tech archi!tech >> %BUILDROOT%\nblog.txt
echo rmdir >> %BUILDROOT%\nblog.txt
rmdir /Q /S S:\!TESTS >> %BUILDROOT%\nblog.txt
echo mkdir >> %BUILDROOT%\nblog.txt
mkdir S:\!TESTS >> %BUILDROOT%\nblog.txt

echo xcopy >> %BUILDROOT%\nblog.txt
xcopy %BUILDROOT%\env\out\exe\NewHT\*.* S:\!TESTS\ /S /Q >> %BUILDROOT%\nblog.txt
rem xcopy %BUILDROOT%\env\out\exe\NewHT\ArchiTest S:\!TESTS\ArchiTest\ /S /Q >> %BUILDROOT%\nblog.txt
rem xcopy %BUILDROOT%\env\out\exe\NewHT\EverestLiteTest S:\!TESTS\EverestLiteTest\ /S /Q >> %BUILDROOT%\nblog.txt
rem xcopy %BUILDROOT%\env\out\exe\NewHT\CreateTestBase S:\!TESTS\CreateTestBase\ /S /Q >> %BUILDROOT%\nblog.txt
rem xcopy %BUILDROOT%\env\out\exe\NewHT\everest2everest S:\!TESTS\everest2everest\ /S /Q >> %BUILDROOT%\nblog.txt

net use S: /D /Y >> %BUILDROOT%\nblog.txt

exit /B


rem !!! БОЛЬШЕ НЕ КОПИРУЕМ В DAILY!!!!


echo. 

:backup
echo net use > %BUILDROOT%\nblog.txt
net use S: \\10.50.128.2\archi /USER:PU\tech archi!tech >> %BUILDROOT%\nblog.txt
call backupdaily.cmd S:\exe\!DAILY

rem exit /B

echo rmdir >> %BUILDROOT%\nblog.txt
rmdir /Q /S S:\exe\!DAILY >> %BUILDROOT%\nblog.txt
echo mkdir >> %BUILDROOT%\nblog.txt
mkdir S:\exe\!DAILY >> %BUILDROOT%\nblog.txt
echo xcopy >> %BUILDROOT%\nblog.txt
xcopy %BUILDROOT%\env\out\exe\*.* S:\exe\!DAILY\ /S /Q >> %BUILDROOT%\nblog.txt
net use S: /D /Y >> %BUILDROOT%\nblog.txt

rem pause
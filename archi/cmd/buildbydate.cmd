rem @echo off
title ARCHI group nightbuild script
SET BUILDROOT=X:\NIGHTBUILD
SET BUILDROOTL=X:\NIGHTBUILD\bydate

rem SET BUILDOPT=-D 2014-09-04 14:22
rem SET BUILDOPT=-r t_arch_0409
rem SET BUILDOPT=

rem SET BUILDOPT=-D "2014-08-07 17:08"

SET BUILDOPT=
SET BUILDSPECOPT=-r B_Very_Old_Storage

rem goto build
rem goto backup

rmdir /S /Q %BUILDROOTL%\env
mkdir %BUILDROOTL%\env

set CVSROOT=:pserver:fireton@cvs.garant.ru:/cvs

rem goto skipcvs

rmdir /S /Q %BUILDROOTL%\cvs
mkdir %BUILDROOTL%\cvs

pushd %BUILDROOTL%\cvs\
cvs -q co -P %BUILDOPT% archi
cvs -q co -P %BUILDOPT% common
cvs -q co -P %BUILDOPT% shared
cvs -q co -P %BUILDOPT% MDProcess
cvs -q co -P %BUILDOPT% build_scripts
popd

pushd %BUILDROOTL%\cvs\common\components\gui\Garant\VCM
cvs update -P -d -r B_Before_No_Module_Internal 
rem cvs -q co -P -r B_Before_No_Module_Internal 
rem cvs -q update -P -r B_Before_No_Module_Internal 
popd

pushd %BUILDROOTL%\cvs\common\components\rtl\Garant\m3
cvs update -P %BUILDSPECOPT% 
popd

rem !заплата!
rem cvs update -P -A common\components\rtl\Garant\m3
rem cvs update -P -r b_archi_old_storage common\components\rtl\Garant\m3

rem pushd %BUILDROOTL%\cvs\common\components\rtl\Garant\m3\
rem cvs update -P -r 1.28 m3define.inc 
rem popd

:skipcvs

:build

subst W: %BUILDROOTL%\cvs
subst M: %BUILDROOTL%\env

mkdir M:\out\units
mkdir M:\out\exe

rem инкрементируем номер сборки
incbuild.exe
call setbuildno.cmd

rem goto buildadmin

rem Начинаем сборку
echo Сборка %BUILDNO% началась %DATE% %TIME% > M:\out\exe\build.log
echo. >> M:\out\exe\build.log
call W:\build_scripts\confbuild.bat "start" "archi" "fakeTag" "%BUILDNO%" "0" ""

rem archi
call versioninfo.cmd Archi W:\archi\source\projects\archi
call buildone.cmd Archi W:\archi\source\projects\archi
call buildone.cmd Archi W:\archi\source\projects\archi Archi_SPLITSTG m3UseSplittedFileStream

rem exit /b

rem AutoPipeServer
call versioninfo.cmd AutoPipeServer W:\archi\source\projects\PipeInAuto
call buildone.cmd AutoPipeServer W:\archi\source\projects\PipeInAuto PipeInAuto_GARANT NB_NPP
call buildone.cmd AutoPipeServer W:\archi\source\projects\PipeInAuto PipeInAuto_NEWHT HT_NEWDLL
call buildone.cmd AutoPipeServer W:\archi\source\projects\PipeInAuto PipeInAuto_AAC NB_AAC
call buildone.cmd AutoPipeServer W:\archi\source\projects\PipeInAuto PipeInAuto_LUK NB_LUK
call buildone.cmd AutoPipeServer W:\archi\source\projects\PipeInAuto PipeInAuto_REGION NB_REGION

rem alcuTaskExecutor
call versioninfo.cmd alcuTaskExecutor W:\archi\source\projects\PipeInAuto\Assistant
call buildone.cmd alcuTaskExecutor W:\archi\source\projects\PipeInAuto\Assistant alcuTaskExecutor_GARANT NB_NPP
call buildone.cmd alcuTaskExecutor W:\archi\source\projects\PipeInAuto\Assistant alcuTaskExecutor_NEWHT HT_NEWDLL
call buildone.cmd alcuTaskExecutor W:\archi\source\projects\PipeInAuto\Assistant alcuTaskExecutor_AAC NB_AAC
call buildone.cmd alcuTaskExecutor W:\archi\source\projects\PipeInAuto\Assistant alcuTaskExecutor_LUK NB_LUK
call buildone.cmd alcuTaskExecutor W:\archi\source\projects\PipeInAuto\Assistant alcuTaskExecutor_REGION NB_REGION

rem mdpSyncPrj
call versioninfo.cmd mdpSyncPrj W:\archi\source\projects\PipeInAuto
call buildone.cmd mdpSyncPrj W:\archi\source\projects\PipeInAuto

rem archi test
call versioninfo.cmd ArchiTest W:\archi\source\projects\archi
call buildone.cmd ArchiTest W:\archi\source\projects\archi

rem goto buildend

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
call buildone.cmd PipeOut2 W:\archi\source\projects\PipeOut PipeOut2_SPLITSTG NB_SPLITSTG

rem NSRCSPY
call versioninfo.cmd NSRCSPY W:\archi\source\projects\PipeIn
call buildone.cmd NSRCSPY W:\archi\source\projects\PipeIn
call buildone.cmd NSRCSPY W:\archi\source\projects\PipeIn NSRCSPY_SPLITSTG NB_SPLITSTG

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

rem stg32
call buildone.cmd stg32 W:\common\components\rtl\Garant\mx\stg32doc

:buildadmin
rem  admin2
call versioninfo.cmd admin2 W:\archi\source\projects\Admin2
call buildone.cmd admin2 W:\archi\source\projects\Admin2
call buildone.cmd admin2 W:\archi\source\projects\Admin2 Admin2_FAS NB_FAS

:buildend

echo. >> M:\out\exe\build.log
echo Сборка завершена %DATE% %TIME% >> M:\out\exe\build.log

pause

subst W: /D
subst M: /D

call "C:\Program Files\Microsoft Visual Studio\VC98\Bin\VCVARS32.BAT"

@echo off
REM -- First make map file from Microsoft Visual C++ generated resource.h
del hlp\Update.hm
echo. >>"hlp\Update.hm"
echo // Dialogs (IDD_*) >>"hlp\Update.hm"
makehm IDD_,HIDD_,0x20000 resource.h >>"hlp\Update.hm"

start /wait hcrtf -x hlp\Update.hpj
if exist Release\nul if exist hlp\Update.hlp copy "hlp\Update.hlp" Release
if exist Release\nul if exist hlp\Update.cnt copy "hlp\Update.cnt" Release

@echo on
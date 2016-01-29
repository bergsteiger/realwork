call "F:\Program Files\Microsoft Visual Studio\VC98\Bin\VCVARS32.BAT"

@echo off
REM -- First make map file from Microsoft Visual C++ generated resource.h
del hlp\GblPilotServerUpdate.hm
echo. >>"hlp\GblPilotServerUpdate.hm"
echo // Dialogs (IDD_*) >>"hlp\GblPilotServerUpdate.hm"
makehm IDD_,HIDD_,0x20000 resource.h >>"hlp\GblPilotServerUpdate.hm"

start /wait hcrtf.exe -x hlp\GblPilotServerUpdate.hpj

if exist Update___Win32_Pilot_Release\nul if exist hlp\GblPilotServerUpdate.hlp copy "hlp\GblPilotServerUpdate.hlp" Update___Win32_Pilot_Release\
if exist Update___Win32_Pilot_Release\nul if exist hlp\GblPilotServerUpdate.cnt copy "hlp\GblPilotServerUpdate.cnt" Update___Win32_Pilot_Release\

@echo on
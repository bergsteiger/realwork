rem @echo off
rem ������ ������
echo ������ ������������ �������� %DATE% � %TIME% > \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.txt
echo. >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.txt

rem ��������� ���������� ��� �������� HELPMAN.EXE
set hm_compile="C:\Program Files (x86)\EC Software\HelpAndManual7\HELPMAN.EXE"

rem AUTOPIPESERVER
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Autopipeserver.AdminGuide.hmxz /tsk=FullBuild:AutoPipeServer.AdminGuide(fCHM) /tsk=FullBuild:AutoPipeServer.AdminGuide(rCHM) /tsk=FullBuild:AutoPipeServer.AdminGuide(rCHM)_!DAILY
echo AUTOPIPESERVER - �� >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.txt 

rem DESCRIPT
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Descript.hmxz "/tsk=Recent Publishes:Descript" "/tsk=Recent Publishes:Descript_!DAILY"
echo DESCRIPT - �� >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.txt

rem NSRCSPY
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Nsrcspy.AdminGuide.hmxz /tsk=FullManual:NSRCSpy.AdminGuide(rCHM) /tsk=FullManual:NSRCSpy.AdminGuide(rCHM)_!DAILY
echo NSRCSPY - �� >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.txt

rem ARHIVARIUS.KOMPLEKS
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Arhivarius.Kompleks.hmxz /tsk=Common:Kompleks.Arhivarius(chm)
echo ARHIVARIUS.KOMPLEKS - �� >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.txt

echo. >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.txt
echo ������ ������������ ��������� %DATE% � %TIME% >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.txt

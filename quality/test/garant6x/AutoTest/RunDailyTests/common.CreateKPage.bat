@echo off
rem � *.bat 䠩� ������ ��।������� ��ࠬ��� � ������
@echo on

rem ������� curdate.xml � ⥪�饩 ��⮩ dd.mm.yy, � ᡮન � ������ ��
wscript.exe //Job:CreateCurdateXMLFile "%~d0%~p0make.wsf" /Build:%1 /PC:%COMPUTERNAME%

rem ������� result.txt � wiki ࠧ��⪮� �� �᭮����� १���⮢ �� perfomance.73.xml
rem � 蠡����� transform.xsl � result.xsl
wscript.exe //Job:CreateWikiText "%~d0%~p0make.wsf" /SourceFile:"%~d0%~p0perfomance.73.xml" /TransformFIle:"%~d0%~p0transform.xsl" /ResultFile:"%~d0%~p0result.xsl" /WikiFile:"%~d0%~p0wikitext.txt"

rem �����㥬 �⨫��� �� ⥪�饩 ᡮન � ����᪠��
COPY "\\DEVELOPER\garant-mdp\deployment\!daily-MDPROCESS\KPageTool\kpagetool.exe"
"%~d0%~p0KPageTool.exe" -GCMConfigFile "%~d0%~p0KPageTool.ini"
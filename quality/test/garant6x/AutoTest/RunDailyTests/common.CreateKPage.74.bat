@echo off
rem � *.bat ���� ������ ������������ �������� � ������
@echo on

rem ������� curdate.xml � ������� ����� dd.mm.yy, � ������ � ������ ��
wscript.exe //Job:CreateCurdateXMLFile "%~d0%~p0make.74.wsf" /Build:%1 /PC:%COMPUTERNAME%

rem ������� result.txt � wiki ��������� �� ��������� ����������� �� perfomance.73.xml
rem � �������� transform.xsl � result.xsl
wscript.exe //Job:CreateWikiText "%~d0%~p0make.74.wsf" /SourceFile:"%~d0%~p0perfomance.74.xml" /TransformFIle:"%~d0%~p0transform.xsl" /ResultFile:"%~d0%~p0result.xsl" /WikiFile:"%~d0%~p0wikitext.txt"

rem �������� ������� �� ������� ������ � ���������
COPY "\\DEVELOPER\garant-mdp\deployment\!daily-MDPROCESS\KPageTool\kpagetool.exe"
"%~d0%~p0KPageTool.exe" -GCMConfigFile "%~d0%~p0KPageTool.74.ini"
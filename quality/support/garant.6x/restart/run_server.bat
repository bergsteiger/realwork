REM ��⠭�������� �ࢥ�
"C:\Garant\apps\winNT\F1ServerStopper.exe" -GCMConfigFile "C:\Garant\garant.ini" -GPMAdapterConfigSection "F1Client Params" %*

REM ���� 40 ᥪ㭤, �.�. �ࢥ� ����� ��⠭���������� � ���㦠�� ���짮��⥫�� 30 ᥪ. + 10 ᥪ㭤 �����
sleep 40

REM ���⨥ ����� Visual Studio
pskill.exe msdev.exe

REM !!!���� �������� ��� �ய��뢠��� ��業���!!!

REM ����� Visual Studio � �믮������ �㭪樨 Main �� �����, �ந��⠫��஢������ � VS
msdev W:\garant6x\implementation\Garant\GblAdapter\gbladapter.dsw -ex StartF1Server
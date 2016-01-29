"C:\Garant\apps\winNT\F1ServerStopper.exe" -GCMConfigFile "C:\Garant\garant.ini" -GPMAdapterConfigSection "F1Client Params" %*
sleep 40
pskill.exe msdev.exe
msdev W:\garant6x\implementation\Garant\GblAdapter\gbladapter.dsw -ex Main
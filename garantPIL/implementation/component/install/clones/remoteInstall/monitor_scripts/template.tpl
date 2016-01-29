echo "Stoping";
C:\4clones\pstools\psservice.exe \\##HOST## -u "##HOST_LOGIN##" -p "##HOST_PASSWORD##" stop "Garant Intranet Web ##PORT_CORBA##:##PORT_ZOPE##"
C:\4clones\pstools\psservice.exe \\##HOST## -u "##HOST_LOGIN##" -p "##HOST_PASSWORD##" stop "Garant Intranet Data ##PORT_CORBA##:##PORT_ZOPE##"

sleep.exe 60

echo "Moving settings";

del /S /Q "\\##HOST##\c$\##INSTALL_PATH##\settings\*.*"
xcopy /Y /E /F C:\4clones\settings_##VERSION##\*.* "\\##HOST##\c$\##INSTALL_PATH##\settings"


echo "Starting";
C:\4clones\pstools\psservice.exe \\##HOST## -u "##HOST_LOGIN##" -p "##HOST_PASSWORD##" start "Garant Intranet Data ##PORT_CORBA##:##PORT_ZOPE##"
sleep.exe 40
C:\4clones\pstools\psservice.exe \\##HOST## -u "##HOST_LOGIN##" -p "##HOST_PASSWORD##" start "Garant Intranet Web ##PORT_CORBA##:##PORT_ZOPE##"


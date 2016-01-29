@echo off
rem в *.bat файл должен передаваться параметр № СБОРКИ
@echo on

rem Создаем curdate.xml с текущей датой dd.mm.yy, № сборки и именем ПК
wscript.exe //Job:CreateCurdateXMLFile "%~d0%~p0make.wsf" /Build:%1 /PC:%COMPUTERNAME%

rem Создаем result.txt с wiki разметкой на основании результатов из perfomance.73.xml
rem и шаблонов transform.xsl и result.xsl
wscript.exe //Job:CreateWikiText "%~d0%~p0make.wsf" /SourceFile:"%~d0%~p0perfomance.73.xml" /TransformFIle:"%~d0%~p0transform.xsl" /ResultFile:"%~d0%~p0result.xsl" /WikiFile:"%~d0%~p0wikitext.txt"

rem Копируем утилиту из текущей сборки и запускаем
COPY "\\DEVELOPER\garant-mdp\deployment\!daily-MDPROCESS\KPageTool\kpagetool.exe"
"%~d0%~p0KPageTool.exe" -GCMConfigFile "%~d0%~p0KPageTool.ini"
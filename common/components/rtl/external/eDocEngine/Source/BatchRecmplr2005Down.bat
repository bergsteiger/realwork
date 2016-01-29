echo off
rem ---> %1- Compiler Path (DCC32.exe).   
rem ---> %2- DPK Path. 
rem ---> %3- Shared Lib Path.
rem ---> %4- eDocEngine Lib Path.
rem ---> %5  DCL DPK Path.
rem ---> %6  eDocEngine Source Path.
rem ---> %7  "<MyDocuments>\Gnostice\eDocEngine VCL\RecompilerLogs.txt"

rem --> Start running batch file from source.
cd %6            
rem %6			

rem --> Write Date to txt file
date /t >> %7    
rem --> Write Time to txt file
time /t >> %7    

echo "Runtime" >> %7
rem ----------------------------------------Recompiler Run Time for Delphi and C++Builder---------------------------------------------
%1 -B %2 -I%3 -I%4 -N%4 -LE%4 -NB%4 -LN%4 -U%3 -U%4 -U%6 -$A+B-C-D-H+I-J-L-M-N+O+P+Q-R-S-T-U-V+W-X+Y- >>%7
%1 -B %2 -DBCB -JPHNE -JP -I%3 -I%4 -N%4 -LE%4 -NB%4 -LN%4 -U%3 -U%4 -U%6 -$A+B-C-D-H+I-J-L-M-N+O+P+Q-R-S-T-U-V+W-X+Y- >> %7

echo "Designtime" >> %5
rem ----------------------------------------Recompiler Design Time for Delphi and C++Builder------------------------------------------
%1 -B %5 -I%3 -I%4 -N%4 -LE%4 -NB%4 -LN%4 -U%3 -U%4 -U%6 -$A+B-C-D-H+I-J-L-M-N+O+P+Q-R-S-T-U-V+W-X+Y- >>%7
%1 -B %5 -DBCB -JPHNE -JP -I%3 -I%4 -N%4 -LE%4 -NB%4 -LN%4 -U%3 -U%4 -U%6 -$A+B-C-D-H+I-J-L-M-N+O+P+Q-R-S-T-U-V+W-X+Y- >> %7

rem echo "OOOOOOOOBBBBJJJJJ" >> %5
rem %1 -B %2 -JPHNE -I%3 -I%4 -NO%3 -NH%3 -NB%4 -N0%4 -U%3 -U%4 >> %7

rem --> Create *.lib using TLIB fot Runtime Package.
TLIB %2.lib      
rem --> Create *.lib using TLIB fot Designtime Package.   
TLIB %5.lib      

rem ---------Tocheck if there is any error, setting the ErrorLevel value to ERROR variable and using in the code---------
cd ..\eDocEngineRecompiler
echo ERROR=%ERRORLEVEL% >Status.txt



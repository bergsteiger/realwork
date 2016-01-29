echo off
rem ---> %1- Compiler Path (DCC32.exe).   
rem ---> %2- DPK Path. 
rem ---> %3- Shared Lib Path.
rem ---> %4- DocEngine Lib Path.
rem ---> %5  DCL DPK Path.
rem ---> %6  Export Component Lib Path.
rem ---> %7  ExportReg.Pas.

date /t >> %9
time /t >> %9
echo ERROR=%ERRORLEVEL% >Status.txt

echo "ExpReg" >> %9
rem ----------------------------------------ExpReg.pas-------------------------------------------------
%1 -B %7 -DBCB -JPHNE -JP -I%3 -LN%4 -LE%4 -NB%4 -N%4 -O%4-U%3 -U%4 -U%6 -$A+B-C-D-H+I-J-L-M-N+O+P+Q-R-S-T-U-V+W-X+Y- >> %9

echo "Runtime" >> %9  
rem ----------------------------------------Exp Intf Run Time for C++Builder-------------------------------------------------
%1 -B %2 -I%3 -LN%4 -LE%4 -NB%4 -N%4 -U%3 -U%4 -U%6 -$A+B-C-D-H+I-J-L-M-N+O+P+Q-R-S-T-U-V+W-X+Y- >> %9
%1 -B %2 -DBCB -JPHNE -JP -I%3 -LN%4 -LE%4 -NB%4 -N%4 -O%4 -U%3 -U%4 -U%6 -$A+B-C-D-H+I-J-L-M-N+O+P+Q-R-S-T-U-V+W-X+Y- >> %9

echo "Designtime" >> %9
rem ----------------------------------------Exp Intf Design Time for C++Builder----------------------------------------------
%1 -B %5 -I%3 -LN%4 -LE%4 -NB%4 -N%4 -U%3 -U%4 -U%6 -$A+B-C-D-H+I-J-L-M-N+O+P+Q-R-S-T-U-V+W-X+Y- >> %9
%1 -B %5 -DBCB -JPHNE -JP -I%3 -LN%4 -LE%4 -NB%4 -N%4 -O%4 -U%3 -U%4 -U%6 -$A+B-C-D-H+I-J-L-M-N+O+P+Q-R-S-T-U-V+W-X+Y- >> %9

rem ---------Tocheck if there is any error, setting the ErrorLevel value to ERROR variable and using in the code---------
echo ERROR=%ERRORLEVEL% >Status.txt

cd %8
tlib.exe %2.lib
tlib.exe %2.lsp
tlib.exe %5.lib
tlib.exe %5.lsp

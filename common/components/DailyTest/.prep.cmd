taskkill /F /IM DailyTest.exe
net use \\lulin-nest lulin!test /USER:Test
xcopy \\lulin-nest\DailyTest\*.* c:\DailyTest /s /y
copy \\LULIN-NEST\_BinOut\Exe\DailyTest.exe C:\DailyTest\
copy \\LULIN-NEST\_BinOut\Exe\DailyTest.map C:\DailyTest\
copy \\LULIN-NEST\_BinOut\Exe\ReleaseDailyTest.exe C:\DailyTest\
copy \\LULIN-NEST\_BinOut\Exe\ReleaseDailyTest.map C:\DailyTest\
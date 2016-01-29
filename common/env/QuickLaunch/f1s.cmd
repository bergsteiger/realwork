if exist "C:\Program Files (x86)\Rational\Rose\rose.exe" (
start "" "C:\Program Files (x86)\Rational\Rose\rose.exe" "W:\shared\models\Nemesis\Nemesis.mdl"
) else (
if "%ProgramFiles(x86)%"=="" (
start "" "C:\Program Files\Rational\Rose\rose.exe" "W:\shared\models\Nemesis\Nemesis.mdl"
) else (
start "" "D:\Program Files\Rational\Rose\rose.exe" "W:\shared\models\Nemesis\Nemesis.mdl"
) )
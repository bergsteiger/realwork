rem start "" "C:\Program Files\Rational\Rose\rose.exe" W:\shared\models\MDProcess\MDProcess.mdl 
rem start "" "C:\Program Files\Rational\Rose\rose.exe" "W:\shared\models\garant_common_template\MDATemplates.mdl"

if "%ProgramFiles(x86)%"=="" (
start "" "C:\Program Files\Rational\Rose\rose.exe" W:\shared\models\MDProcess\MDProcess.mdl
) else (
start "" "D:\Program Files\Rational\Rose\rose.exe" W:\shared\models\MDProcess\MDProcess.mdl
)
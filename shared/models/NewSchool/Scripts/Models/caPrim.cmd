pushd W:\shared\models\NewSchool\Scripts\Models
call clearbackup.cmd
call clear.cmd
W:\common\env\QuickLaunch\msgen.exe W:\shared\models\NewSchool\Scripts\Models\*.ms.model.script "%~1"
popd
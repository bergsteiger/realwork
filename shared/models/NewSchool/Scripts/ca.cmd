pushd W:\shared\models\NewSchool\Scripts
call clearbackup.cmd
call clear.cmd
call makeInject.cmd
W:\common\env\QuickLaunch\msgen.exe W:\shared\models\NewSchool\Scripts\*.ms.model.script "%~1"
popd
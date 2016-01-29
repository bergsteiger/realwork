call substs_del.cmd

subst h: "%homedrive%%homepath%"

if "%COMPUTERNAME%" NEQ "LULIN-BOOK2" goto other
 set work="C:\Users\8523~1\Dropbox\realwork"
 set workd=c:

goto skip 

:other

if exist "%homedrive%%homepath%\DropBox\_CVS_rem" (
 set work="%homedrive%%homepath%\DropBox\_CVS"
 set workd=c:
) else (
 if exist C:\_CVS (
  set workd=c:
  subst d: c:\
 ) else (
  set workd=d:
 )
 set work=%workd%\_CVS
)

:skip
subst w: "%work%"
subst u: "%work%\common\components\gui\Garant"
subst j: "%work%\common\components\rtl\Garant"
subst p: "%work%\garant6x\implementation\Garant"
subst v: "%work%\common\components\rtl\External"
subst b: "%homedrive%%homepath%\Dropbox\SVN\rumtmarc\trunk\Blogger"
rem subst b: "%work%\common\components\business"
subst m: "%work%\shared\models"
subst s: "%work%\shared"
subst g: "%work%\MDProcess"
subst l: "%work%\common\components\DailyTest"
subst t: "%work%\shared\support\mdagen\templates"
subst q: "%work%\common\env\QuickLaunch"
subst o: "%workd%\_BinOut"
subst r: "%work%\archi\source\projects"
net use i: \\tom-w\pub
net use y: \\lin-store\garant-nemesis
net use n: \\lin-store\garant-mdp
net use k: \\archi\archi /user:gar-store\lulin
net use x: \\test-low1\dailytest

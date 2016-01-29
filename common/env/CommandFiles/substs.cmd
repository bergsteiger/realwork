subst h: "%homedrive%%homepath%"

if exist "%homedrive%%homepath%\DropBox\_CVS" (
 set work="%homedrive%%homepath%\DropBox\_CVS"
) else (
 if exist C:\_CVS (
  set work=c:\_CVS
 ) else (
  set work=d:\_CVS
 )
)

call %work%\common\env\CommandFiles\substsonly.cmd
call W:\common\env\CommandFiles\startfar.cmd 
call W:\common\env\CommandFiles\startfar.cmd 
call W:\common\env\CommandFiles\startfar.cmd 

call %work%\common\env\CommandFiles\opencvss.cmd
rem call q:\cq.cmd
call q:\mdp.cmd

REM CommandInterpreter: $(COMSPEC)
::
::
:: module:  execcomp.bat
:: author:  Mickael P. Golovin
::
:: Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
::
:: $Id: execcomp.bat,v 1.1 2008/02/07 09:54:17 lulin Exp $
::
::
@echo off
:begin

  set $COMP$="brcc32"
  set $MASK$="*.rc"

  if `%$COMP$%` == `` goto end
  if `%$MASK$%` == `` goto end

  echo.
  echo resource files compile begin

  pushd ".\..\pas"

   path ".\..\build";%PATH% & for %%1 in (%$MASK$%) do echo  file "%%1" & %$COMP$% %%1 1>nul & if errorlevel 1 echo  file "%%1" found error... & pause 1>nul

  popd

  echo resource files compile end
  echo.


  goto end

:end
@endlocal

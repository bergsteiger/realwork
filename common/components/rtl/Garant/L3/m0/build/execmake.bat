REM CommandInterpreter: $(COMSPEC)
::
::
:: module:  execmake.bat
:: author:  Mickael P. Golovin
::
:: Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
::
:: $Id: execmake.bat,v 1.1 2008/02/07 09:54:17 lulin Exp $
::
::
@echo off
:begin

  set $MAKE$="makedata"
  set $MASK$="*.txt"

  if `%$MAKE$%` == `` goto end
  if `%$MASK$%` == `` goto end

  echo.
  echo resource files make begin

  pushd ".\..\pas"

   path ".\..\build";%PATH% & for %%1 in (%$MASK$%) do echo  file "%%1" & %$MAKE$% %%1 & if errorlevel 1 echo  file "%%1" found error... & pause 1>nul

  popd

  echo resource files make end
  echo.

  goto end

:end
@endlocal

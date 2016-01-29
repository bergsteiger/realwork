::
::
:: module:  m0bcblib.bat
:: author:  Mickael P. Golovin
::
:: Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
::
:: $Id: m0bcblib.bat,v 1.1 2008/02/07 09:54:17 lulin Exp $
::
::
@echo off
:begin

  set $COMP$="bcc32"
  set $MASK$="m0???lib.c"

  if `%$COMP$%` == `` goto end
  if `%$MASK$%` == `` goto end

  set $CCFLAGS$=-O2 -w- -pr -a8 -5 -d -vi -c
  set $DEFINES$=-D"_m0LZOMINIVERSION;_m0REXMINIVERSION"
  set $INCLUDE$=-I".\..\include;.\..\..\..\external\mfx\minilzo;.\..\..\..\external\gnu\grep\src"
  set $OUTPATH$=-n".\..\pas"

  echo.
  echo object files compile begin

  pushd ".\..\c"

   path ".\..\build";%PATH% & for %%1 in (%$MASK$%) do echo  file "%%1" & %$COMP$% %$CCFLAGS$% %$INCLUDE$% %$DEFINES$% %$OUTPATH$% %%1 1>nul & if errorlevel 1 echo  file "%%1" found error... & pause 1>nul

  popd

  echo object files compile end
  echo.


  goto end

:end
@endlocal

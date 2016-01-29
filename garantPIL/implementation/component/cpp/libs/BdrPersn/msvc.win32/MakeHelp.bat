@echo off & setlocal

 :main
  :main.begin

    set ERR_EXT=.err
    set GID_EXT=.gid
    set HLP_EXT=.hlp
    set HPJ_EXT=.hpj

    set NAME=breedr32

    del /f /q %NAME%%ERR_EXT% 1>nul 2>&1
    del /f /q %NAME%%GID_EXT% 1>nul 2>&1
    del /f /q %NAME%%HLP_EXT% 1>nul 2>&1

    start /wait hcw /C /E /M %NAME%%HPJ_EXT%
    start /wait winhlp32 -G %NAME%%HLP_EXT%

    attrib -h %NAME%%GID_EXT% 1>nul 2>&1

    if not $%1$==$$ (copy /y %NAME%%HLP_EXT% %1 1>nul 2>&1)
    if not $%2$==$$ (copy /y %NAME%%GID_EXT% %2 1>nul 2>&1)

  :main.end

@endlocal & exit /b

@echo off & setlocal

 :main
  :main.begin

    set HOME=%1

    pushd %HOME%\..\docs
      
     ..\bin\cvs.exe -d :pserver:webclient@developer.garant.ru:/export/home/cvs co %2

    popd

  :main.end

@endlocal & exit

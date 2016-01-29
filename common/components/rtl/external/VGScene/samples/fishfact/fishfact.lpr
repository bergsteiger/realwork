program fishfact;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, dbflaz, fishfactfrm, vgscene;

{$R *.res}

begin
  Application.Initialize;
  Application.Run;
end.


program TimeEvents;

uses
  Forms,
  TimeEventsMain in 'TimeEventsMain.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.

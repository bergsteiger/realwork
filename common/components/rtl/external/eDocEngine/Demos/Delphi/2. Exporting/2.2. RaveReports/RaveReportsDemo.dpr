program RaveReportsDemo;

uses
  Forms,
  eDocRave in 'eDocRave.pas' {frmRave};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmRave, frmRave);
  Application.Run;
end.

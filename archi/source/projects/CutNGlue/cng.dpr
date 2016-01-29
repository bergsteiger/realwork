program cng;

uses
  Forms,
  cngMain in 'cngMain.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cut''n''Glue';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

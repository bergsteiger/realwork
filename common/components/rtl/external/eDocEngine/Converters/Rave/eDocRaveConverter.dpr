program eDocRaveConverter;

uses
  Forms,
  Main in 'Main.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'eDocEngine Rave Converter';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

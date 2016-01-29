program eDocAceConverter;

uses
  Forms,
  Main in 'Main.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'eDocEngine Ace Converter';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

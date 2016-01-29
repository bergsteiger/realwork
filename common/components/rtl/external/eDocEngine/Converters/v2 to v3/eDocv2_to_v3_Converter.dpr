program eDocv2_to_v3_Converter;

uses
  Forms,
  Main in 'Main.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'eDocEngine v2 to v3 Converter';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

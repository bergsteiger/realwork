program LivePreview;

uses
  System.StartUpCopy,
  FMX.Forms,
  Consts in 'Consts.pas',
  Regs in 'Regs.pas',
  StreamingUnit in 'StreamingUnit.pas',
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  PreviewFormUnit in 'PreviewFormUnit.pas' {PreviewForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'FireUI App Preview';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

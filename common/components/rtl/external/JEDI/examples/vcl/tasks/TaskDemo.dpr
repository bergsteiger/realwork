program TaskDemo;

uses
  Forms,
  JclTask in '..\..\..\source\windows\JclTask.pas',
  TaskDemoMain in 'TaskDemoMain.pas' {frmMain},
  TaskDemoDataModule in 'TaskDemoDataModule.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

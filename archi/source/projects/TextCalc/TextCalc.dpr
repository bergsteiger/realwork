program TextCalc;

{$I ProjectDefine.inc}

uses
  evdSchema,
  Forms,
  TextCalcMain in 'TextCalcMain.pas' {MainForm};

{$R *.res}
{$R versioninfo.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

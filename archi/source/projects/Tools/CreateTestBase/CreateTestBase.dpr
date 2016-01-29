program CreateTestBase;

{$I ProjectDefine.inc}

uses
  Forms,
  evdSchema,
  MainForm in 'MainForm.pas' {SpyForm};

{$R *.RES}
{$R versioninfo.res} // включаем Version Info

begin
  Application.Title := 'Import/export test';
  Application.CreateForm(TTestForm, TestForm);
  Application.Run;
end.

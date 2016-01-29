program imexTest;

{$I *.inc}

uses
  Forms,
  evdSchema,
  MainForm in 'MainForm.pas' {SpyForm};

{$R *.RES}

begin
  Application.Title := 'Import/export test';
  Application.CreateForm(TTestForm, TestForm);
  Application.Run;
end.

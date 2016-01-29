program DictSync;

{$I ProjectDefine.inc}

uses
  Forms,
  evdSchema,
  MainForm in 'MainForm.pas' {DictSyncForm};

{$R *.res}
{$R versioninfo.res} // включаем Version Info

begin
  Application.Initialize;
  Application.Title := 'Корректор словаря Классы';
  Application.CreateForm(TDictSyncForm, DictSyncForm);
  Application.Run;
end.

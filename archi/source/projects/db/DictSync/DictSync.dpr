program DictSync;

{$I ProjectDefine.inc}

uses
  Forms,
  evdSchema,
  MainForm in 'MainForm.pas' {DictSyncForm};

{$R *.res}
{$R versioninfo.res} // �������� Version Info

begin
  Application.Initialize;
  Application.Title := '��������� ������� ������';
  Application.CreateForm(TDictSyncForm, DictSyncForm);
  Application.Run;
end.

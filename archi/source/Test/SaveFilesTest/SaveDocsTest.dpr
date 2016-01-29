program SaveDocsTest;

{$I *.inc}

uses
  Forms,
  Dialogs,
  SysUtils,
  evdSchema,
  MainForm in 'MainForm.pas' {SpyForm};

{$R *.RES}

begin
 if ParamCount = 2 then
 begin
  DataPath := ParamStr(1);
  BasePath := ParamStr(2);
 end // if ParamCount = 1 then
 else
 if ParamCount = 3 then
 begin
  DataPath := ParamStr(1);
  BasePath := ParamStr(2);
  OddData := AnsiLowerCase(ParamStr(3)) = 'odd';
 end // if ParamCount = 3 then
 else
 begin
  ShowMessage('�� ������ ���������: <����_�_������> <����_�_����> <��������>');
  Exit;
 end;

 Application.Title := 'Save Docs Test';
 Application.CreateForm(TTestForm, TestForm);
 Application.Run;
end.

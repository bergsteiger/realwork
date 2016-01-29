unit cb_Main;

{$I ProjectDefine.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, l3Types, Mask, ToolEdit;

type
  TMainForm = class(TForm)
    btnStart: TButton;
    ProgressBar: TProgressBar;
    lblDisplay: TLabel;
    rbUpdate: TRadioButton;
    rbCreate: TRadioButton;
    lblRemoteCacheDir: TLabel;
    deRemoteCacheDir: TDirectoryEdit;
    cbDocs: TCheckBox;
    cbEditions: TCheckBox;
    cbStruct: TCheckBox;
    rbExternal: TRadioButton;
    cbOneDoc: TCheckBox;
    edOneDoc: TEdit;
    rbCleanupCache: TRadioButton;
    rbService: TRadioButton;
    procedure btnStartClick(Sender: TObject);
    procedure RadiobuttonClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoProgress(aState: Byte; aValue: Long; const aMsg: String = '');
    procedure DoSomeServiceStuff;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 l3Interfaces,
 ddAutolinkCache,
 dtIntf,
 dt_Sab,
 dt_LinkServ,
 Dt_ReNum,
 dt_Const,
 dt_Doc,
 cb_Misc;


{$R *.dfm}

procedure TMainForm.DoProgress(aState: Byte; aValue: Long; const aMsg: String = '');
begin
 case aState of
  piStart:
   begin
    ProgressBar.Visible := True;
    lblDisplay.Visible := True;
    lblDisplay.Caption := aMsg;
    ProgressBar.Max := aValue;
    ProgressBar.Position := 0;
   end;

  piCurrent:
   begin
    ProgressBar.Position := aValue;
   end;

  piEnd:
   begin
    lblDisplay.Caption := '';
    ProgressBar.Position := ProgressBar.Max;
   end;
 end;
 Application.ProcessMessages;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
var
 I: Integer;
 l_DocID: Integer;
 l_Sab: ISab;
begin
 if rbExternal.Checked and ((deRemoteCacheDir.Text = '') or not DirectoryExists(deRemoteCacheDir.Text)) then
 begin
  MessageDlg('Укажите существующую директорию на диске', mtError, [mbOK], 0);
  FocusControl(deRemoteCacheDir);
  Exit;
 end;

 btnStart.Enabled := False;
 try
  Application.ProcessMessages;

  if rbUpdate.Checked then
  begin
   if not cbOneDoc.Checked then
    UpdateAutolinkCache(DoProgress)
   else
   begin
    l_DocID := StrToIntDef(edOneDoc.Text, -1);
    if l_DocID > 0 then
    begin
     l_DocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(l_DocID);
     if l_DocID <> cUndefDocID then
     begin
      l_Sab := MakeValueSet(DocumentServer(CurrentFamily).FileTbl, fId_Fld, @l_DocID, 1);
      BuildActualDocsCache(DoProgress, l_Sab);
      BuildEditionsCache(DoProgress, l_Sab);
      BuildStructCache(DoProgress, l_Sab);
     end
     else
      MessageDlg('Такого документа нет в базе', mtError, [mbOK], 0);
    end
    else
     MessageDlg('Неверный ID документа', mtError, [mbOK], 0);
   end;
  end

  else

  if rbCreate.Checked then
  begin
   if cbDocs.Checked then
    BuildActualDocsCache(DoProgress);
   if cbEditions.Checked then
    BuildEditionsCache(DoProgress);
   if cbStruct.Checked then
    BuildStructCache(DoProgress);
   TouchAutolinkCache;
  end

  else

  if rbExternal.Checked then
   MakeRemoteAutolinkCache(deRemoteCacheDir.Text)

  else

  if rbCleanupCache.Checked then
   CleanupAutolinkCache(DoProgress)

  else

  if rbService.Checked then
   DoSomeServiceStuff

  else
   MessageDlg('Нереализованный функционал', mtError, [mbOk], 0);

 finally
  btnStart.Enabled := True;
 end;
end;

procedure TMainForm.DoSomeServiceStuff;
begin
 UpcaseNumbersInCache;
end;

procedure TMainForm.RadiobuttonClick(Sender: TObject);
begin
 cbDocs.Enabled     := rbCreate.Checked;
 cbEditions.Enabled := rbCreate.Checked;
 cbStruct.Enabled   := rbCreate.Checked;

 lblRemoteCacheDir.Enabled := rbExternal.Checked;
 deRemoteCacheDir.Enabled  := rbExternal.Checked;

 cbOneDoc.Enabled := rbUpdate.Checked;
 edOneDoc.Enabled := cbOneDoc.Enabled and cbOneDoc.Checked;
end;

end.

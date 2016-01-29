unit adMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  l3StringList,
  l3Types,
  adEngine,

  OvcBase, afwControlPrim, afwBaseControl, afwControl,
  afwInputControl, vtLister, StdCtrls, l3Interfaces, ComCtrls;

type
  TMainForm = class(TForm)
    btnAdd: TButton;
    btnDelete: TButton;
    lstItems: TvtLister;
    btnDistribute: TButton;
    btnRestore: TButton;
    ProgressBar: TProgressBar;
    lblDisp: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDistributeClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstItemsActionElement(Sender: TObject; Index: Integer);
    procedure lstItemsCountChanged(Sender: TObject; NewCount: Integer);
    procedure lstItemsGetItemColor(Sender: TObject; Index: Integer; var FG, BG: TColor);
    procedure lstItemsGetStrItem(Sender: TObject; Index: Integer; var ItemString: Il3CString);
  private
    f_CurProcMsg: AnsiString;
    { Private declarations }
    f_Manager: TadManager;
    procedure AddNewItem;
    procedure DispMsg(const aMsg: AnsiString; aIsError: Boolean = False);
    procedure DoDistribute;
    procedure DoProgress(aState: Byte; aValue: Long; const aMsg: AnsiString = '');
    procedure DoRestore;
    function EditItem(anItem: TadItem): Boolean;
    procedure EnableUI(Value: Boolean);
    function GetArchiveFolder: AnsiString;
    function GetDataFilename: AnsiString;
    function GetNewArchiveFilename: AnsiString;
    procedure SendNotificationEmail(const aDate: TDateTime);
    function ShowErrorsBox(const aTitle, aText: AnsiString; const aErrList: Tl3StringList; aYesNo: Boolean): Integer;
    procedure UpdateButtons;
  public
    procedure UpdateLister;
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 l3Base,
 l3String,

 l3FileUtils,
 l3IniFile,
 l3Filer,
 l3ShellUtils,
 
 adItemEdit,
 adErrorBox,
 adArchiveList,

 DateUtils;

{$R *.dfm}

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_Manager);
end;

procedure TMainForm.AddNewItem;
var
 l_Item: TadItem;
begin
 l_Item := TadItem.Create;
 try
  if EditItem(l_Item) then
  begin
   f_Manager.AddItem(l_Item);
   UpdateLister;
  end;
 finally
  FreeAndNil(l_Item);
 end;
end;

procedure TMainForm.btnAddClick(Sender: TObject);
begin
 AddNewItem;
end;

procedure TMainForm.btnDeleteClick(Sender: TObject);
var
 l_Idx: Integer;
begin
 l_Idx := lstItems.Current;
 if MessageDlg(Format('Вы действительно ходите удалить "%s"?', [l3Str(lstItems.Strings[l_Idx])]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
 begin
  f_Manager.DeleteItem(l_Idx);
  UpdateLister;
 end;
end;

procedure TMainForm.btnDistributeClick(Sender: TObject);
begin
 DoDistribute;
end;

procedure TMainForm.btnRestoreClick(Sender: TObject);
begin
 DoRestore;
end;

procedure TMainForm.DispMsg(const aMsg: AnsiString; aIsError: Boolean = False);
begin
 lblDisp.Caption := aMsg;
 if aIsError then
  lblDisp.Font.Color := clRed
 else
  lblDisp.Font.Color := clWindowText;
end;

procedure TMainForm.DoDistribute;
var
 l_ArchiveFN: AnsiString;
 l_ErrList: Tl3StringList;
begin
 f_Manager.RefreshValidity;
 if not f_Manager.IsValid then
 begin
  DispMsg('Сборка невалидна!', True);
  Exit;
 end;
 l_ErrList := Tl3StringList.MakeSorted;
 try
  if f_Manager.CheckDistribution(l_ErrList) then
  begin
   EnableUI(False);
   try
    if ForceDirectories(GetArchiveFolder) then
    begin
     l_ArchiveFN := GetNewArchiveFilename;
     f_Manager.Archive(l_ArchiveFN, DoProgress);
     f_Manager.Distribute(DoProgress);
     SendNotificationEmail(Now);
     DispMsg('Новая версия успешно подложена!');
    end
    else
     DispMsg('Папка с архивами недоступна!', True);
   finally
    EnableUI(True);
   end;
  end
  else
   ShowErrorsBox('Заняты файлы', 'Невозможно выполнить задание. Следующие целевые файлы заняты:', l_ErrList, False);
 finally
  FreeAndNil(l_ErrList);
 end;
end;

procedure TMainForm.DoProgress(aState: Byte; aValue: Long; const aMsg: AnsiString = '');
begin
 case aState of
  piStart:
   begin
    ProgressBar.Max := aValue;
    ProgressBar.Position := 0;
    f_CurProcMsg := aMsg;
    DispMsg(aMsg);
   end;
  piCurrent:
   begin
    ProgressBar.Position := aValue;
    DispMsg(aMsg);
   end;
  piEnd:
   begin
    ProgressBar.Position := ProgressBar.Max;
    DispMsg(f_CurProcMsg);
   end;
 end;
 Application.ProcessMessages;
end;

procedure TMainForm.DoRestore;
begin
 
end;

function TMainForm.EditItem(anItem: TadItem): Boolean;
var
 l_EditForm: TadItemEditDlg;
begin
 l_EditForm := TadItemEditDlg.Create(Self);
 try
  l_EditForm.Item := anItem;                                                             
  Result := l_EditForm.Execute;
 finally
  FreeAndNil(l_EditForm);
 end;
end;

procedure TMainForm.EnableUI(Value: Boolean);
begin
 btnAdd.Enabled := Value;
 btnDelete.Enabled := Value;
 btnDistribute.Enabled := Value;
 btnRestore.Enabled := Value;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 f_Manager := TadManager.Create(GetDataFilename);
 f_Manager.Load;
 UpdateLister;
end;

function TMainForm.GetArchiveFolder: AnsiString;
begin
 Result := ConcatDirName(ExtractFilePath(Application.ExeName), 'ARCHIVES');
end;

function TMainForm.GetDataFilename: AnsiString;
begin
 Result := ChangeFileExt(Application.ExeName, '.dat');
end;

function TMainForm.GetNewArchiveFilename: AnsiString;
var
 D, M, Y, H, MN, S, MS: Word;
 l_FN: AnsiString;
begin
 DecodeDateTime(Now, Y, M, D, H, MN, S, MS);
 l_FN := Format('archive-%.4d-%.2d-%.2d-%.2d-%.2d.zip', [Y, M, D, H, MN]);
 Result := ConcatDirName(GetArchiveFolder, l_FN);
end;

procedure TMainForm.lstItemsActionElement(Sender: TObject; Index: Integer);
var
 l_Item: TadItem;
begin
 l_Item := f_Manager.Items[Index];
 if EditItem(l_Item) then
 begin
  lstItems.InvalidateItem(Index);
  f_Manager.Save;
 end;
end;

procedure TMainForm.lstItemsCountChanged(Sender: TObject; NewCount: Integer);
begin
 UpdateButtons;
end;

procedure TMainForm.lstItemsGetItemColor(Sender: TObject; Index: Integer; var FG, BG: TColor);
begin
 if f_Manager.Items[Index].IsValid then
  FG := clWindowText
 else
  FG := clRed; 
end;

procedure TMainForm.lstItemsGetStrItem(Sender: TObject; Index: Integer; var ItemString: Il3CString);
begin
 ItemString := l3CStr(f_Manager.Items[Index].Name);
end;

procedure TMainForm.SendNotificationEmail(const aDate: TDateTime);
var
 l_Ini: Tl3IniFile;
 l_ToAddress: AnsiString;
 l_Filer : Tl3DOSFiler;
 l_Str: AnsiString;
begin
 l_Ini := Tl3IniFile.Create;
 try
  l_Ini.Section := 'Email';
  l_ToAddress := l_Ini.ReadParamStrDef('SendTo', '');
  if l_ToAddress <> '' then
  begin
   if FileExists('blat.exe') then
   begin
    l_Filer := Tl3DOSFiler.Make('mailopt.txt', l3_fmWrite);
    try
     l_Filer.Open;
     l_Filer.WriteLn('-server smtp.garant.ru');
     l_Filer.WriteLn('-f archi@garant.ru');
     l_Filer.WriteLn('-charset windows-1251');
     l_Filer.WriteLn(Format('-to "%s"', [l_ToAddress]));
     DateTimeToString(l_Str, 'dd/mm/yyyy', aDate);
     l_Filer.WriteLn(Format('-subject "Подложена версия Архивариуса от %s"', [l_Str]));
     l_Filer.WriteLn('-bodyF "mailbody.txt"');
     l_Filer.Close;
    finally
     FreeAndNil(l_Filer);
    end;

    l_Filer := Tl3DOSFiler.Make('mailbody.txt', l3_fmWrite);
    try
     l_Filer.Open;
     l_Filer.WriteLn('Уважаемые коллеги!');
     l_Filer.WriteLn('');
     l_Filer.WriteLn(Format('Обратите внимание, что на сервер была подложена версия Архивариуса от %s', [l_Str]));
     l_Filer.WriteLn('');
     l_Filer.WriteLn('Всегда ваши,');
     l_Filer.WriteLn('группа "Архивариус"');
     l_Filer.WriteLn('');
     l_Filer.WriteLn('--------------------------------------');
     l_Filer.WriteLn('Это письмо создано автоматически, вам не нужно отвечать на него.');
     l_Filer.Close;
    finally
     FreeAndNil(l_Filer);
    end;

    FileExecuteWait('blat.exe', '- -of "mailopt.txt"', '', esMinimized);

   end
   else
    l3System.Msg2Log('Не найден blat.exe, письмо не отправлено!');
  end;
 finally
  FreeAndNil(l_Ini);
 end;
end;

function TMainForm.ShowErrorsBox(const aTitle, aText: AnsiString; const aErrList: Tl3StringList; aYesNo: Boolean):
 Integer;
var
 l_Dlg: TErrorBox;
begin
 l_Dlg := TErrorBox.Create(aTitle, aText, aErrList);
 try
  l_Dlg.IsYesNo := aYesNo;
  Result := l_Dlg.ShowModal;
 finally
  FreeAndNil(l_Dlg);
 end;
end;

procedure TMainForm.UpdateButtons;
begin
 btnDelete.Enabled := lstItems.Total > 0;
end;

procedure TMainForm.UpdateLister;
begin
 lstItems.Total := f_Manager.ItemCount;
 lstItems.Invalidate;
end;

end.

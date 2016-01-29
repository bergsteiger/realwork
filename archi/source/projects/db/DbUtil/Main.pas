unit Main;

{ $Id: Main.pas,v 1.17 2014/12/25 15:43:51 voba Exp $ }
// $Log: Main.pas,v $
// Revision 1.17  2014/12/25 15:43:51  voba
// - функции восстановления Priority и SortDate
//
// Revision 1.16  2012/12/03 11:01:56  voba
// - tune
//
// Revision 1.15  2011/12/12 14:06:50  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.14  2010/12/29 12:17:01  voba
// [k:248195393]
//
// Revision 1.13  2009/06/02 09:37:22  narry
// - корректная работа с диапазонами номеров
//
// Revision 1.12  2009/03/05 09:04:09  narry
// - инициализация заданием папки с базой
//
// Revision 1.11  2008/03/25 14:20:19  narry
// - добавлена процедура замены ссылок на элемент словаря
//
// Revision 1.10  2007/06/26 09:14:06  narry
// - поддержка команды !SERVICEINFO
//
// Revision 1.9  2007/05/11 10:39:54  narry
// - процедура обновления FREE доступна из интерфейса
//
// Revision 1.8  2007/05/11 08:24:14  narry
// - исправление ряда ошибок
//
// Revision 1.7  2007/04/17 13:09:20  narry
// - процедура создания произвольной пустой базы
//
// Revision 1.6  2005/04/07 18:47:51  step
// изменен запрос папки для копии БД
//
// Revision 1.5  2005/03/17 13:37:19  step
// убран TElFolderDialog
//
// Revision 1.4  2004/10/07 12:14:41  step
// реализована переиндексация
//
// Revision 1.3  2004/09/22 09:11:26  step
// доделано восстановление таблицы
//
// Revision 1.2  2004/08/03 17:08:19  step
// добавлены операции для ремонта БД
//
// Revision 1.1  2004/07/21 16:58:59  step
// утилита по обслуживанию БД - занесена в CVS
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ActnList, Menus, ComCtrls,
  DbService, Mask, ToolEdit, dt_Const, AppEvnts, ddProcessDlg, XPMan;

type

TProgressData = record
 rState   : Byte;
 rMsg     : String;
 rPercent : byte;
 rMax : Cardinal;
end;

type
  TMainForm = class(TForm)
   StatusBar: TStatusBar;
   MainMenu: TMainMenu;
   ActionList: TActionList;
   actClose: TAction;
    miFile: TMenuItem;
    miExit: TMenuItem;
   actArchiIni: TAction;
    miArchiIni: TMenuItem;
   FileDialog: TOpenDialog;
   mInfo: TMemo;
    miActions: TMenuItem;
    miBuildCopy: TMenuItem;
    actWhoLock: TAction;
    actClearLocks: TAction;
    N3: TMenuItem;
    ActRepairTable: TAction;
    actReindexTable: TAction;
    actReindexAllTables: TAction;
    mReindex: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    actUpdateFreeTable: TAction;
    actMakeBaseCopy: TAction;
    FREE1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    actReplaceLinks: TAction;
    N1: TMenuItem;
    XPManifest1: TXPManifest;
    actDeleteBadLinkToDict: TAction;
    LinkDict1: TMenuItem;
    actJrnlUnpack: TAction;
    N4: TMenuItem;
    acCorrectForbiddenValue: TAction;
    N6: TMenuItem;
    acRecoverSortDate: TAction;
    N7: TMenuItem;
    acRecoverPriority: TAction;
    N8: TMenuItem;

   procedure actCloseExecute(Sender: TObject);
   procedure actArchiIniExecute(Sender: TObject);
   procedure FormCreate(Sender: TObject);
   procedure FormClose(Sender: TObject; var Action: TCloseAction);
   procedure actWhoLockExecute(Sender: TObject);
   procedure actDbServiceAvailable(Sender: TObject);
   procedure actClearLocksExecute(Sender: TObject);
    procedure ActRepairTableExecute(Sender: TObject);
    procedure actReindexTableExecute(Sender: TObject);
    procedure actReindexAllTablesExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actUpdateFreeTableExecute(Sender: TObject);
    procedure actMakeBaseCopyExecute(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure actReplaceLinksExecute(Sender: TObject);
    procedure actDeleteBadLinkToDictExecute(Sender: TObject);
    procedure actJrnlUnpackExecute(Sender: TObject);
    procedure acCorrectForbiddenValueExecute(Sender: TObject);
    procedure acRecoverSortDateExecute(Sender: TObject);
    procedure acRecoverPriorityExecute(Sender: TObject);
  private
   f_DbService: TDbService;
   fProgressData : TProgressData;
   //f_InfoDlg: TddProcessDialog;
   procedure SetBase(const aFolder: String);
   //procedure AddInfo(aItem: String; aValue: Integer = -1);
   procedure AddToLog(const aStr: string);
   procedure OutProgress(const aProgressData : TProgressData);
   procedure BeginProcess(const aStr: string);
   procedure EndProcess;

   function DbServiceAvailable: Boolean;
   //procedure FinishInfo;
   //procedure StartInfo(aValue: Integer = -1);
  public
   procedure BeginWait(aMessage: string; aProcesses: TddProcess = nil);
   procedure EndWait;

   procedure DoProgressProc(aState : Byte; aValue: Longint; const aMsg : String = '');
  end;

var
  MainForm: TMainForm;

implementation

uses
 DT_DbInfo, FileCtrl,
 l3Types, l3Interfaces,
 l3Math,
 BaseCopyDialog, ChooseLinkTableDialog, dt_Types, l3FileUtils;

{$R *.dfm}


const
piClear = 255;
{TProgressData = record
 rState   : Byte;
 rMsg     : String;
 rPercent : byte;
 rMax : Cardinal;
end;
}

function MakeProgressData(aState : Byte; aValue: Cardinal = 0; const aMsg : String = '') : TProgressData;
begin
 with Result do
 begin
  rState := aState;
  rMsg := aMsg;
  if rState = piStart then
   begin
    rPercent := 0;
    rMax := aValue;
   end
   else
    rPercent := aValue;
 end;
end;

function EditProgressData(var aPrgData : TProgressData; aState : Byte; aValue: Cardinal = 0; const aMsg : String = '') : boolean;
var
 lPercent : Byte;
begin
 with aPrgData do
 begin
  if (rState = piClear) and (aState = piEnd) then
  begin
   Result := False;
   Exit;
  end;

  Result := rState <> aState;
  rState := aState;

  if (aMsg <> '') and (rMsg <> aMsg) then
  begin
   rMsg := aMsg;
   Result := True;
  end;

  case aState of
   piStart :
    begin
     rPercent := 0;
     Result := Result or (rMax <> aValue);
     rMax := aValue;
    end;
   piCurrent :
    begin
     lPercent := l3MulDiv(aValue, 100, rMax);
     Result := Result or (rPercent <> lPercent);
     rPercent := lPercent;
    end;
   piClear :
    begin
     lPercent := 0;
     rMsg := '';
     rMax := 0;
    end;
  end;
 end;
end;

procedure TMainForm.OutProgress(const aProgressData : TProgressData);
begin
 with mInfo.Lines do
 case aProgressData.rState of
  piStart : Strings[Pred(Count)] := format('%s : %s',[aProgressData.rMsg, '...']);
  piCurrent : Strings[Pred(Count)] := format('%s : %d%%',[aProgressData.rMsg, aProgressData.rPercent]);
  piEnd : Strings[Pred(Count)] := format('%s : %s',[aProgressData.rMsg, 'сделано']);
 end;
end;

procedure TMainForm.AddToLog(const aStr: string);
begin
 mInfo.Lines.Add(aStr);
 Application.ProcessMessages;
end;

procedure TMainForm.BeginProcess(const aStr: string);
begin
 DoProgressProc(piStart, 0, aStr);
end;

procedure TMainForm.EndProcess;
begin
 DoProgressProc(piEnd, 0, '');
end;

procedure TMainForm.DoProgressProc(aState : Byte; aValue: Longint; const aMsg : String = '');
begin
 case aState of
  piStart :
   begin
    AddToLog(aMsg);
    EditProgressData(fProgressData, aState, aValue, aMsg);
    OutProgress(fProgressData);
   end;
  piCurrent :
   if EditProgressData(fProgressData, aState, aValue, aMsg) then
    OutProgress(fProgressData);
  piEnd :
   begin
    if EditProgressData(fProgressData, piEnd) then
     OutProgress(fProgressData);
    EditProgressData(fProgressData, piClear);
   end;
 end;

 //if f_InfoDlg <> nil then
 // f_InfoDlg.ProgressProc(aState, aValue, aMsg);

end;

procedure TMainForm.actCloseExecute(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.actArchiIniExecute(Sender: TObject);
var
 l_Folder: String;
begin
 if SelectDirectory(l_Folder, [sdPrompt], 0) then
  SetBase(l_Folder);
end;

procedure TMainForm.SetBase(const aFolder: String);
var
 l_Folders: Integer;
begin
 begin //Нужно проверить папку на наличие правильных подпапок
  l_Folders:= 0;
  if DirectoryExists(ConcatDirName(aFolder, 'HOMES')) then
   Inc(l_Folders);
  if DirectoryExists(ConcatDirName(aFolder, 'MAIN')) then
   Inc(l_Folders);
  if DirectoryExists(ConcatDirName(aFolder, 'SHARE')) then
   Inc(l_Folders);
  if DirectoryExists(ConcatDirName(aFolder, 'GARANT')) then
   Inc(l_Folders);
  if l_Folders = 4 then
   f_DBService.InitFolder(aFolder)
  else
   MessageDlg('В указанной папке отсутствует одна из папок GARANT, MAIN, HOMES или SHARE', mtError, [mbOk], 0);
 end; // SelectDirectory(l_Folder, [sdPrompt], 0)
 mInfo.Text := f_DbService.Information;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 f_DbService := TDbService.Create;
 f_DbService.WriteToLogProc := MainForm.AddToLog;
 f_DbService.ProgressProc := DoProgressProc;
 mInfo.Text := f_DbService.Information;

 EditProgressData(fProgressData, piClear); // clear
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 FreeAndNil(f_DbService);
end;

procedure TMainForm.actWhoLockExecute(Sender: TObject);
begin
 BeginWait('Выполняется поиск активных захватчиков.');
 try
  // Family
  f_DbService.ShowTableHolders(f_DbService.DbInfo.FamilyFolder);
  f_DbService.ShowRecordsHolders(f_DbService.DbInfo.FamilyFolder);

  // Main
  f_DbService.ShowTableHolders(f_DbService.DbInfo.MainFolder);
  f_DbService.ShowRecordsHolders(f_DbService.DbInfo.MainFolder);
 finally
  EndWait;
 end;
end;

function TMainForm.DbServiceAvailable: Boolean;
begin
 Result := f_DbService.IsActive;
end;

procedure TMainForm.actDbServiceAvailable(Sender: TObject);
begin
 (Sender as TAction).Enabled := DbServiceAvailable;
end;

procedure TMainForm.actClearLocksExecute(Sender: TObject);
begin
 MainForm.BeginWait('Выполняется чистка захватов.');
 try
  BeginProcess('Чистка таблиц семейства');
  f_DbService.ClearLocks(f_DbService.DbInfo.FamilyFolder);
  EndProcess;

  BeginProcess('Чистка административных таблиц');
  f_DbService.ClearLocks(f_DbService.DbInfo.MainFolder);
  EndProcess;
 finally
  MainForm.EndWait;
 end;
end;

procedure TMainForm.BeginWait(aMessage: string; aProcesses: TddProcess = nil);
begin
 Screen.Cursor := crHourGlass;
 StatusBar.SimpleText := aMessage;
 //if f_InfoDlg = nil then
 // f_InfoDlg:= MakeProcessDialog(aMessage, aProcesses)
 //else
 // f_InfoDlg.Title:= aMessage;
 f_DbService.ProgressProc := DoProgressProc;
end;

procedure TMainForm.EndWait;
begin
 //FreeAndNil(f_InfoDlg);
 Screen.Cursor := crDefault;
 StatusBar.SimpleText := '';
end;

procedure TMainForm.ActRepairTableExecute(Sender: TObject);
begin
 with FileDialog do
 begin
  FileName := '';
  InitialDir := f_DbService.DbInfo.FamilyFolder;
  Title := 'Укажите таблицу';
  DefaultExt := 'htb';
  Filter := '*.htb|*.htb|*.*|*.*';

  if Execute then
  begin
   MainForm.BeginWait('Выполняется восстановление таблицы.');
   try
    BeginProcess('Исправление таблиц');
    f_DbService.RepairTable(FileName);
    EndProcess;
   finally
    MainForm.EndWait;
   end;
  end; // if

 end; // with
end;

procedure TMainForm.actReindexTableExecute(Sender: TObject);
begin
 with FileDialog do
 begin
  FileName := '';
  InitialDir := f_DbService.DbInfo.FamilyFolder;
  Title := 'Укажите таблицу';
  DefaultExt := 'htb';
  Filter := '*.htb|*.htb|*.*|*.*';

  if Execute then
  begin
   MainForm.BeginWait('Выполняется переиндексация таблицы.');
   try
    BeginProcess('Переиндекация таблицы');
    f_DbService.ReindexTable(FileName);
    EndProcess;
   finally
    MainForm.EndWait;
   end;
  end; // if
 end; // with
end;

procedure TMainForm.actReindexAllTablesExecute(Sender: TObject);
var
 l_Folder: string;
begin
 BeginWait('Выполняется переиндексация таблиц.');
 try
  if InputQuery('Введите', 'Папка с таблицами', l_Folder) then
  begin
   if DirectoryExists(l_Folder) then
   begin
    BeginProcess('Переиндекация таблиц');
    f_DbService.ReindexAllTables(l_Folder);
    EndProcess;
   end
   else
    ShowMessage(Format('Неверное имя папки: %s', [l_Folder]));
  end;

 finally
  EndWait;
 end;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
 lBaseFolder : String;
begin
 lBaseFolder := ParamStr(1);
 if lBaseFolder <> '' then
  SetBase(lBaseFolder)
 else
  if MessageDlg('Для работы программы нужно указать расположение базы данных. Хотите сделать это сейчас?',mtConfirmation, mbYesNoCancel, 0) = mrYes then
   actArchiIni.Execute;
end;

procedure TMainForm.actUpdateFreeTableExecute(Sender: TObject);
begin
 //BeginWait('Коррекция свободных номеров',
 try
  BeginProcess('Коррекция свободных номеров');
  f_DBService.UpdateFreeTables;
  EndProcess;
 finally
  EndWait;
 end;
end;

procedure TMainForm.actDeleteBadLinkToDictExecute(Sender: TObject);
begin
 //BeginWait('Чистка мусора в атрибутах',
 try
  BeginProcess('Чистка мусора в атрибутах');
  f_DBService.DeleteBadLinkToDict;
  EndProcess;
 finally
  EndWait;
 end;

end;


procedure TMainForm.actMakeBaseCopyExecute(Sender: TObject);
begin
 {BeginWait('Создание копии базы',
  BeginProcess('Создание копии базы', -1,
  BeginProcess('Коррекция начальных значений', -1)));}
 try
  with TBaseCopyDlg.Create(nil) do
  try
   if Execute then
   begin
    BeginProcess('Создание копии базы');
    f_DbService.MakeCustomCopy(BaseFolder, DictSet, WithUsers);
    EndProcess;

    BeginProcess('Коррекция начальных значений');
    f_DBService.CorrectTables(Dictset, WithUsers);
    EndProcess;
   end
  finally
   Free;
  end;
 finally
  EndWait;
 end;
end;

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
begin
 StatusBar.SimpleText := Application.Hint;
end;

procedure TMainForm.actReplaceLinksExecute(Sender: TObject);
var
 l_Link: TFamTbls;
 l_Old, l_New: Integer;
begin
 with TChooseLinkTableDlg.Create(nil) do
 try
  if Execute(l_Link, l_Old, l_New) then
   f_DbService.ReplaceLinks(l_Link, l_Old, l_New);
 finally
  Free;
 end;
end;

//procedure TMainForm.AddInfo(aItem: String; aValue: Integer = -1);
//begin
// if f_InfoDlg <> nil then
//  f_InfoDlg.Add(aItem, aValue);
//end;

//procedure TMainForm.FinishInfo;
//begin
// if f_InfoDlg <> nil then
//  f_InfoDlg.Finish;
//end;

//procedure TMainForm.ShowInfo;
//begin
// if f_InfoDlg <> nil then
//  f_InfoDlg.Show;
//end;

//procedure TMainForm.StartInfo(aValue: Integer = -1);
//begin
// if f_InfoDlg <> nil then
//  f_InfoDlg.Start;
//end;

procedure TMainForm.actJrnlUnpackExecute(Sender: TObject);
begin
 with FileDialog do
 begin
  FileName := '';
  if (f_DbService <> nil) and (f_DbService.DbInfo <> nil) then
   InitialDir := f_DbService.DbInfo.FamilyFolder;
  Title := 'Укажите таблицу';
  DefaultExt := 'htb';
  Filter := '*.htb|*.htb|*.*|*.*';

  if Execute then
  begin
   //MainForm.BeginWait('Выполняется распаковка журнала.');
   try
    BeginProcess('Распаковка журнала');
    f_DbService.JrnlUnpack(FileName);
    EndProcess;
   finally
    MainForm.EndWait;
   end;
  end; // if
 end; // with
end;

procedure TMainForm.acCorrectForbiddenValueExecute(Sender: TObject);
begin
 with FileDialog do
 begin
  FileName := '';
  if (f_DbService <> nil) and (f_DbService.DbInfo <> nil) then
   InitialDir := f_DbService.DbInfo.FamilyFolder;
  Title := 'Укажите таблицу';
  DefaultExt := 'htb';
  Filter := '*.htb|*.htb|*.*|*.*';

  if Execute then
  begin
   //MainForm.BeginWait('Исправление запрещенных значений.');
   try
    AddToLog('Исправление запрещенных значений');
    //BeginProcess('Исправление запрещенных значений');
    f_DbService.CorrectForbiddenValue(FileName);
    //EndProcess;
   finally
    MainForm.EndWait;
   end;
  end; // if
 end; // with
end;

procedure TMainForm.acRecoverSortDateExecute(Sender: TObject);
begin
 f_DbService.RecoverSortDate;
end;

procedure TMainForm.acRecoverPriorityExecute(Sender: TObject);
begin
  f_DbService.RecoverPriority;
end;

end.

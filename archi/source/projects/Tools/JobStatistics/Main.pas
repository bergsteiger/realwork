unit Main;

{ $Id: Main.pas,v 1.25 2016/06/10 11:43:37 lukyanets Exp $ }
// $Log: Main.pas,v $
// Revision 1.25  2016/06/10 11:43:37  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.24  2016/04/18 11:47:33  lukyanets
// Готовимся переводить UserManager
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.23  2015/04/27 09:20:17  fireton
// - bugfix
//
// Revision 1.22  2015/04/07 09:08:07  lukyanets
// Изолируем домашний каталог
//
// Revision 1.21  2015/04/01 15:25:43  lukyanets
// Изолируем логин
//
// Revision 1.20  2015/04/01 11:54:38  lukyanets
// Изолируем утилиты
//
// Revision 1.19  2015/01/22 14:31:15  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.18  2014/10/16 10:41:40  lukyanets
// Более контролируемо создаем конфиги
//
// Revision 1.17  2007/11/30 14:08:44  narry
// - сборка под 129-ю версию базы
//
// Revision 1.16  2007/04/12 09:18:49  fireton
// - bugfix
//
// Revision 1.15  2005/12/13 16:02:04  step
// чтоб собиралась
//
// Revision 1.14  2005/05/17 09:32:32  lulin
// - cleanup.
//
// Revision 1.13  2004/12/23 11:47:16  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.12  2004/10/19 11:18:05  step
// исправление ошибки неправильной сортировки при втором etc поиске
//
// Revision 1.11  2004/10/19 08:23:57  step
// bug fix
//
// Revision 1.10  2004/10/07 14:24:51  step
// убрано поле f_StageFlag
//
// Revision 1.9  2004/10/07 10:16:08  step
// убрано одно из условий поиска ("Состояние")
//
// Revision 1.8  2004/10/06 16:31:16  step
// - исправлен подсчет суммарного объема документов
// - исправлена проверка пароля
//
// Revision 1.7  2004/10/06 10:42:41  step
// вывод ВСЕХ условий поиска
//
// Revision 1.6  2004/10/05 17:10:49  step
// изменена форма выводимых данных (агрегирование по юзеру и дате)
//
// Revision 1.5  2004/10/04 10:12:07  step
// выдаются внешние номера, а не внутренние
//
// Revision 1.4  2004/10/04 09:06:52  step
// две даты (начало, конец) сведены к одной
//
// Revision 1.3  2004/10/01 11:18:44  step
// изменено форматирование результатов и др. мелочи
//
// Revision 1.2  2004/10/01 09:28:57  step
// добавлено получение номеров документов
//
// Revision 1.1  2004/09/30 18:07:01  step
// занесено в CVS
//

interface

{$I ProjectDefine.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  Dt_Const, dt_Types,
  l3Base,
  l3ObjectRefList,
  l3Types, Mask, vtCombo, ExtCtrls, vtDateEdit,
  BaseSupport, XPMan;
type

 TJobInfo = class(Tl3Base)
 private
  function DateIsEmpty(aDate: TDateTime): Boolean;
 protected
  function LastDate: TDateTime; // из двух дат (начало, конец) использется только одна
 public
  UserId: Longint;
  UserName: string;
  BeginDate,
  EndDate: TDateTime;
  InternalDocId: Longint;
  DocSize: Longint;
  function OCompare(anObject: Tl3Base): Long; override;
 end;

 TJobStatistics = class(Tl3Base)
 private
  f_BeginDate,
  f_EndDate: TDateTime;
  f_UserId: Word;
  f_Stage: TStageType;

  f_Jobs: Tl3ObjectRefList;
 protected
  procedure Search(aBeginDate, aEndDate: TDateTime;
                   aUserId: Word;
                   aStage: TStageType);
  procedure CalcUserNames;
  procedure CalcDocSizes;
  procedure Cleanup; override;
 public
  constructor Create; reintroduce;
  procedure CalculateFor(aBeginDate, aEndDate: TDateTime;
                         aUserId: Word;
                         aStage: TStageType);
  procedure SaveToFile(aFileName: string);
  function JobsAmount: Integer;
 end;

 TMainForm = class(TForm)
  bGo: TButton;
  SaveDialog: TSaveDialog;
  bClose: TButton;
  Label6: TLabel;
  Label7: TLabel;
  Label4: TLabel;
  cbUser: TComboBox;
  cbStage: TComboBox;
  GroupBox2: TGroupBox;
  Label9: TLabel;
  Label10: TLabel;
  edtLowDate: TvtDateEdit;
  edtHighDate: TvtDateEdit;
  Bevel1: TBevel;
    XPManifest1: TXPManifest;
  procedure bGoClick(Sender: TObject);
  procedure FormCreate(Sender: TObject);
  procedure FormClose(Sender: TObject; var Action: TCloseAction);
  procedure bCloseClick(Sender: TObject);
 private
  f_JobStatistics: TJobStatistics;
  procedure DisableControls;
  procedure EnableControls;
 public
  function SearchDescript: string;
  function UserNameById(aId: Integer): string;
 end;

procedure GlobalInit;
procedure GlobalDone;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 ncsDefaultProviderHolder,
 daDataProvider,
 Ht_Dll, Ht_Const,
 Dt_Srch, Dt_Query, Dt_Doc, Dt_Hyper, Dt_Free, Dt_Containers,
 Dt_Mail, l3IniFile, Dt_user, Dt_Stage, Dt_Dict, Dt_ATbl, Dt_Renum,
 D_pass, DictsSup, StrShop,
 //ddUserRequest,
 l3FileUtils, l3Date, l3Memory, 
 //GardocBridge,
 l3ExceptionsLog,//m0EXCLib,
 vtDialogs,
 IniShop,
 VersionSupport,
 AttrTypes,
 //DocImgSup,
 Math, Contnrs,
 m3DBInterfaces,
 m2ComLib;

const
 c_ColumnDelim = #9;
 EOL = #13#10;

procedure GlobalInit;
var
 Ok            : Boolean;
 I             : Integer;
 ServerCfgPath : String;
 lLockMsg      : String;

 l_LogPathStr  : String;

begin
 Screen.Cursor := crHourGlass;
 try
  InitStationAndServerConfig('Archi.ini');

  StationConfig.Section := 'EXE';
  l_LogPathStr := StationConfig.ReadParamStrDef('LogFile','');

  if Length(l_LogPathStr) = 0 then
   l_LogPathStr := ChangeFileExt(Application.ExeName, '.log');
  Gm0EXCLibDefSrv.LogFileName := l_LogPathStr;

 // AddExitProc(GlobalDone);

  If IsBaseLocked(lLockMsg) then
  begin
   vtMessageDlg(l3CStr(lLockMsg), mtInformation);
   StationConfig.Section := PrefSectName;
   If Not StationConfig.ReadParamBoolDef('Admin',false) then
    Abort;
  end;

  MailServer:=TMailServer.Create;

  StationConfig.Section := PrefSectName;

  try
   TncsDefaultProviderHolder.CreateProvider;
  except
   On E : Exception do
   begin
    Application.ShowException(E);
    Abort;
   end;
  end;

  If (GlobalDataProvider.Login = '') or (GlobalDataProvider.Password = '') then
   Ok := GetPassword
  else
   Ok := True;
  try
   I := 1;
   While Ok and (I <= 3) and
         (Not GlobalDataProvider.CheckPassword(False)) do
   begin
    Ok := GetPassword;
    Inc(I);
   end;
  except
   On E : Exception do
   begin
    Application.ShowException(E);
    Raise;
   end;
  end;
  If Not Ok or (I > 3) then Abort;

  StationConfig.Section:='User';
  StationConfig.WriteParamStr('UserName',UserPassName);
  UserConfig:=TCfgList.Create(GlobalDataProvider.CurHomePath+'User.ini');
  IniRec.SetIniRecord;

  //IniRec.MultiLingual := True;
  IniRec.MultiLingual := GlobalDataProvider.UserManager.IsMemberOfGroup(ugBiLingualGroup, GlobalDataProvider.UserID);
  DictServer.BiLingual := IniRec.MultiLingual;

  IniRec.PathToLogFile := l_LogPathStr;
  //IniRec.PathToDeletedFileList := ConcatDirName(ExtractDirName(l_LogPathStr),'Deleted.lst');

  StationConfig.Section:='User';
  UserPassName:=StationConfig.ReadParamStrDef('UserName','');

  StationConfig.Section := PrefSectName;
  IniRec.DebugInfo := StationConfig.ReadParamBoolDef('DebugInfo2', False);

 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure GlobalDone;
begin
 Screen.Cursor := crHourGlass;
 try
  IniRec.SaveIniRecord;
  l3Free(MailServer);
  TncsDefaultProviderHolder.DestroyProvider;

  DoneConfigs;
 finally
  Screen.Cursor := crDefault;
 end;
end;

{ TJobStatistics }

procedure TJobStatistics.CalcDocSizes;
var
 I: Integer;
 l_InternalDocId: Integer;
 l_Doc: Im3DBDocument;
begin
 if (f_Jobs <> nil) and (f_Jobs.Count > 0) then
 begin
  for I := 0 to f_Jobs.Count - 1 do
  begin
   l_InternalDocId := TJobInfo(f_Jobs.Items[I]).InternalDocId;
   l_Doc := dtGetDB(CurrentFamily).GetDocument(l_InternalDocId);
   try
    TJobInfo(f_Jobs.Items[I]).DocSize := m2ComGetSize(l_Doc.Open);
   finally
    l_Doc := nil;
   end;
  end;
 end;
end;

procedure TJobStatistics.CalculateFor(aBeginDate, aEndDate: TDateTime;
  aUserId: Word; aStage: TStageType);
begin
 Search(aBeginDate, aEndDate, aUserId, aStage);
 CalcUserNames;
 CalcDocSizes;
end;

procedure TJobStatistics.CalcUserNames;
var
 I: Integer;
begin
 if (f_Jobs <> nil) and (f_Jobs.Count > 0) then
 begin
  for I := 0 to f_Jobs.Count - 1 do
  begin
   TJobInfo(f_Jobs.Items[I]).UserName :=
    MainForm.UserNameById(TJobInfo(f_Jobs.Items[I]).UserId);
  end;
 end;
end;

procedure TJobStatistics.Cleanup;
begin
 l3Free(f_Jobs);

 inherited;
end;

constructor TJobStatistics.Create;
begin
 inherited Create;

 f_Jobs := Tl3ObjectRefList.Make;
end;

function TJobStatistics.JobsAmount: Integer;
begin
 if (f_Jobs <> nil) then
  Result := f_Jobs.Count
 else
  Result := 0;
end;

procedure TJobStatistics.SaveToFile(aFileName: string);
var
 l_FileStream: TFileStream;
 I: Integer;
 l_CurJob: TJobInfo;
 l_CurUserName: string;
 l_CurUserId: Integer;
 l_CurDate: TDateTime;
 l_DocsAmount: Integer;
 l_DocsSize: Integer;
 l_Str: string;

 procedure WriteStrToFile;
 begin
  l_Str := l_CurUserName + c_ColumnDelim +
           DateToStr(l_CurDate) + c_ColumnDelim +
           IntToStr(l_DocsAmount) + c_ColumnDelim +
           IntToStr(l_DocsSize) + EOL;
  l_FileStream.Write(l_Str[1], Length(l_Str));
 end;
begin
 if f_Jobs.Count = 0 then
  Exit;

 l_FileStream := TFileStream.Create(aFileName, fmCreate);
 try
  // заголовок
  l_Str := MainForm.SearchDescript;
  l_FileStream.Write(l_Str[1], Length(l_Str));

  // суммированные (по юзеру, дате) данные
  f_Jobs.Sorted := True;
  l_CurUserId := 0;
  l_CurUserName := '';
  l_CurDate := 0;
  for I := 0 to f_Jobs.Count - 1 do
  begin
   l_CurJob := TJobInfo(f_Jobs.Items[I]);
   if   (l_CurUserId = l_CurJob.UserId)
    and (l_CurDate   = l_CurJob.LastDate) then
   begin
    Inc(l_DocsAmount);
    Inc(l_DocsSize, l_CurJob.DocSize);
   end
   else
   begin
    if (I > 0) then
     WriteStrToFile;

    l_CurUserId := l_CurJob.UserId;
    l_CurUserName := l_CurJob.UserName;
    l_CurDate := l_CurJob.LastDate;

    l_DocsAmount := 1;
    l_DocsSize := l_CurJob.DocSize;
   end;

   if I = f_Jobs.Count - 1 then
    WriteStrToFile; // последняя строчка
  end; // for

 finally
  l_FileStream.Free;
 end;
end;

procedure TJobStatistics.Search(aBeginDate, aEndDate: TDateTime;
                                aUserId: Word;
                                aStage: TStageType);
const
 c_StageFields: array[0..4] of Smallint =
 (stDocID_Key, stType_Key, stBDate_Key, stEDate_Key, stAuthor_Key);

var
 l_Stages : Sab;
 l_ValuesIterator: TValuesIterator;
 l_JobInfo: TJobInfo;
 l_BDate,
 l_EDate: LongWord;

begin
 // запомним параметры поиска - для вывода в файл
 f_BeginDate := aBeginDate;
 f_EndDate   := aEndDate;
 f_UserId    := aUserId;
 f_Stage     := aStage;

 f_Jobs.Sorted := False;
 f_Jobs.Clear;

 DocumentServer.Family := CurrentFamily;
 l_Stages := DocumentServer.StageTbl.FilteredBy(StDateToDemon(DateTimeToStDate(aBeginDate)),
                                                StDateToDemon(DateTimeToStDate(aEndDate)),
                                                stfFinished,
                                                aUserId,
                                                aStage);
 try
  if l_Stages.gFoundCnt > 0 then
  begin
   l_ValuesIterator := TValuesIterator.Create(l_Stages, c_StageFields);
   try
    while not l_ValuesIterator.EOF do
    begin
     l_JobInfo := TJobInfo.Create;
     try
      l_ValuesIterator.Read(stDocID_Key,  l_JobInfo.InternalDocId);

      l_ValuesIterator.Read(stBDate_Key,  l_BDate);
      l_JobInfo.BeginDate := StDateToDateTime(DemonToStDate(l_BDate));

      l_ValuesIterator.Read(stEDate_Key,  l_EDate);
      l_JobInfo.EndDate   := StDateToDateTime(DemonToStDate(l_EDate));

      l_ValuesIterator.Read(stAuthor_Key, l_JobInfo.UserId);

      f_Jobs.Add(l_JobInfo);
     finally
      l3Free(l_JobInfo);
     end;

     l_ValuesIterator.Next;
    end;
   finally
    l3Free(l_ValuesIterator);
   end;
  end;
 finally
  htClearResults(l_Stages);
 end;
end;

procedure TMainForm.bGoClick(Sender: TObject);
var
 l_Str: string;
begin
 if IsBaseLocked(l_Str) then
  MessageDlg('Доступ к базе закрыт. (' + l_Str +')', mtError, [mbOK], 0)
 else
 begin
  DisableControls;
  try
   Application.ProcessMessages;
   Screen.Cursor := crHourGlass;
   try
    f_JobStatistics.CalculateFor(edtLowDate.Date,
                                 edtHighDate.Date,
                                 Word(cbUser.Items.Objects[cbUser.ItemIndex]),
                                 TStageType(cbStage.Items.Objects[cbStage.ItemIndex]));
    if f_JobStatistics.JobsAmount > 0 then
    begin
     if SaveDialog.Execute then
      f_JobStatistics.SaveToFile(SaveDialog.FileName);
    end
    else
     MessageDlg('Ничего не найдено.',
                mtInformation, [mbOK], 0);
   finally
    Screen.Cursor := crDefault;
   end;
  finally
   EnableControls;
  end;
 end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 I: TStageType;
begin
 try
  f_JobStatistics := TJobStatistics.Create;
 except
  f_JobStatistics := nil;
 end;

 UserManager.GetFiltredUserList(cbUser.Items);
 cbUser.Items.Insert(0, '[ВСЕ]');
 cbStage.Items.Insert(0, '[ВСЕ]');
 For I := Succ(Succ(Low(TStageType))) to High(TStageType) do
  cbStage.Items.AddObject(StageStringConst[I],TObject(I));
 cbUser     .ItemIndex := 0;
 cbStage    .ItemIndex := 0;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 l3Free(f_JobStatistics);
end;

{ TJobInfo }

function TJobInfo.OCompare(anObject: Tl3Base): Long;
begin
 if (anObject is TJobInfo) then
 begin
  Result := AnsiCompareStr(Self.UserName, TJobInfo(anObject).UserName);
  if Result = 0 then
   Result := CompareValue(Self.LastDate, TJobInfo(anObject).LastDate);
  if Result = 0 then
   Result := CompareValue(Self.InternalDocId, TJobInfo(anObject).InternalDocId);
  if Result = 0 then
   Result := CompareValue(Self.DocSize, TJobInfo(anObject).DocSize);
 end
 else
  Result := inherited OCompare(anObject);
end;

function TMainForm.SearchDescript: string;
begin
 // параметры поиска
 Result := '';

 //if cbUser.ItemIndex > 0 then
  Result := Result + 'Разработчик: ' + cbUser.Text + EOL;
 //if not edtLowDate.IsEmpty then
  Result := Result + 'C  ' + edtLowDate.Text + EOL;
 //if not edtHighDate.IsEmpty then
  Result := Result + 'По ' + edtHighDate.Text + EOL;
 //if cbStage.ItemIndex > 0 then
  Result := Result + 'Этап: ' + cbStage.Text + EOL;

 // заголовок таблицы
 Result := Result + EOL +
           'Разработчик' + c_ColumnDelim +
           'Дата' + c_ColumnDelim +
           'Кол-во' + c_ColumnDelim +
           'Объем' + EOL + EOL;
end;

function TMainForm.UserNameById(aId: Integer): string;
var
 l_Index: Integer;
begin
 l_Index := cbUser.Items.IndexOfObject(Pointer(aId));
 if l_Index >= 0 then
  Result := cbUser.Items[l_Index]
 else
  Result := IntToStr(aId);
end;

function TJobInfo.DateIsEmpty(aDate: TDateTime): Boolean;
begin
 Result := (aDate = StDateToDateTime(DemonToStDate(0)))
        or (aDate > StrToDate('31.12.2099'))
        or (aDate < StrToDate('01.01.1900'));
end;

procedure TMainForm.bCloseClick(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.DisableControls;
begin
 bGo.Enabled := False;
 bClose.Enabled := False;
 edtLowDate.Enabled := False;
 edtHighDate.Enabled := False;
 cbUser.Enabled := False;
 cbStage.Enabled := False;
end;

procedure TMainForm.EnableControls;
begin
 bGo.Enabled := True;
 bClose.Enabled := True;
 edtLowDate.Enabled := True;
 edtHighDate.Enabled := True;
 cbUser.Enabled := True;
 cbStage.Enabled := True;
end;

function TJobInfo.LastDate: TDateTime;
begin
 // самая последняя
 if not DateIsEmpty(EndDate) then
  Result := EndDate
 else
  Result := BeginDate;
end;

end.





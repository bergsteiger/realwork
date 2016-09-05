unit bbsMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, vtCombo, vtDateEdit, ToolEdit, ExtCtrls,
  l3Types,
  daTypes
  ;

type
  PWorkStatData = ^TWorkStatData;
  TWorkStatData = record
   rDuration : DWORD;
   rPauses   : DWORD;
  end;

  TMainForm = class(TForm)
    deFrom: TvtDateEdit;
    lblDate1: TLabel;
    lblDate2: TLabel;
    deTo: TvtDateEdit;
    cbRegion: TComboBox;
    Label3: TLabel;
    feResultFile: TFilenameEdit;
    lblOutFile: TLabel;
    btnStart: TButton;
    btnExit: TButton;
    Timer1: TTimer;
    procedure btnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private
    f_GlobalStats: TWorkStatData;
    { Private declarations }
    f_PathToExe: string;
    f_Region: TdaRegionID;
  public
    procedure CheckStartConditions;
    procedure FillRegionsCombo;
    procedure FormReport;
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 DateUtils,

 l3Base,
 l3Date,
 l3DateSt,
 l3RecList,
 l3Stream,
 l3DataPtrList,
 l3ObjectRefList,
 //l3VStorage,

 daInterfaces,
 daTypes,

 DT_Table,
 DT_Sab;

{$R *.dfm}


type
 PSessionData = ^TSessionData;
 TSessionData = record
  rID       : DWORD;
  rUserID   : DWORD;
  rStartDate: DWORD;
  rStartTime: DWORD;
  rEndDate  : DWORD;
  rEndTime  : DWORD;
  rWorkStat : TWorkStatData;
 end;

 PUserDataHolder = ^TUserDataHolder;
 TUserDataHolder = class(Tl3Base)
 private
  f_ID: TdaUserID;
  f_Sessions: Tl3DataPtrList;
  f_TotalDuration: Integer;
  f_TotalPauses: Integer;
  f_DateFrom : TStDate;
  f_Stats    : Tl3RecList;
 protected
  procedure Cleanup; override;
  procedure IncDurations(aDuration, aPauses: Integer);
 public
  constructor Create(anID: TdaUserID; aStatStartDate: TStDate; aStatDaysCount: Integer); reintroduce;
  procedure CalcDayByDayStats;
  procedure PrintStats(aText: Tl3TextStream);
  property ID: TdaUserID read f_ID;
  property Sessions: Tl3DataPtrList read f_Sessions;
  property TotalDuration: Integer read f_TotalDuration write f_TotalDuration;
  property TotalPauses: Integer read f_TotalPauses write f_TotalPauses;
 end;


function TimeString(const aTime: TStTime): string;
var
 H, M, S: Integer;
begin
 if aTime < 0 then
  Result := '-'
 else
 begin
  StTimeToHMS(aTime, H, M, S);
  Result := Format('%d:%d', [H,M]);
 end; 
end;


function FormatWorkStats(const aDuration: TStTime; const aPauses: TStTime): string;
begin
 if aDuration < 60 then // если меньше минуты, считаем что не работал
  Result := ''
 else
  Result := Format('%s/%s (%s)', [TimeString(aDuration - aPauses), TimeString(aDuration), TimeString(aPauses)]);
end;


procedure TMainForm.btnExitClick(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.CheckStartConditions;
var
 l_IsDatesOK   : Boolean;
 l_IsOutFileOK : Boolean;
begin
 l_IsDatesOK := deFrom.Date < deTo.Date;
 l_IsOutFileOK := DirectoryExists(ExtractFileDir(feResultFile.FileName));
 if not l_IsDatesOK then
 begin
  lblDate1.Font.Color := clRed;
  lblDate2.Font.Color := clRed;
 end
 else
 begin
  lblDate1.Font.Color := clWindowText;
  lblDate2.Font.Color := clWindowText;
 end;
 if not l_IsOutFileOK then
  lblOutFile.Font.Color := clRed
 else
  lblOutFile.Font.Color := clWindowText;
 btnStart.Enabled := l_IsDatesOK and l_IsOutFileOK; 
end;

procedure TMainForm.FillRegionsCombo;
var
 l_RegTbl: TdtTable;
 l_Sab   : ISab;
 l_Proc: TdtRecAccessProc;

 function l_Iterator(aRec : Pointer) : Boolean;
 var
  l_Name: PChar;
  l_ID  : TdaRegionID;
 begin
  l_RegTbl.GetFieldFromRecord(aRec, 1, l_ID);
  l_RegTbl.GetFieldFromRecord(aRec, 2, l_Name);
  try
   cbRegion.Items.AddObject(l_Name, TObject(l_ID));
  finally
   l3StrDispose(l_Name);
  end;
  Result := True;
 end;

begin
 f_PathToExe := ExtractFilePath(Application.ExeName);
 l_RegTbl := TdtTable.CreateWithOpen(f_PathToExe, '', 'REGIONS', 0);
 try
  l_Sab := MakeSab(l_RegTbl);
  try
   l_Sab.SelectAll;
   l_Proc := L2RecAccessProc(@l_Iterator);
   try
    cbRegion.Items.Clear;
    l_Sab.IterateRecords(l_Proc, [1,2]);
    cbRegion.ItemIndex := 0;
   finally
    FreeRecAccessProc(l_Proc);
   end;
  finally
   l_Sab := nil;
  end;
 finally
  l3Free(l_RegTbl);
 end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 FillRegionsCombo;
 deTo.Date := Now;
 deFrom.Date := IncDay(Now, -30);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
 CheckStartConditions;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
 f_Region := TdaRegionID(cbRegion.Items.Objects[cbRegion.ItemIndex]);
 FormReport;
end;

procedure TMainForm.FormReport;
var
 l_Tbl : TdtTable;
 l_Sab : ISab;
 l_FromDate  : TStDate;
 l_ToDate    : TStDate;
 l_DaysInStat: Integer;
 l_UserList: Tl3ObjectRefList;
 l_SessList: Tl3RecList;
 l_DayStats: Tl3RecList;
 l_Iter: TdtRecAccessProc;
 l_File : Tl3TextStream;
 l_ACCount : Integer;
 l_ACDocs  : LongWord;
 I: Integer;

 function FindSession(aSessID: DWORD): PSessionData;
 var
  l_Cur: PSessionData;
  I : Integer;
 begin
  Result := nil;
  for I := 0 to Pred(l_SessList.Count) do
  begin
   l_Cur := PSessionData(l_SessList.ItemSlot(I));
   if l_Cur.rID = aSessID then
   begin
    Result := l_Cur;
    Break;
   end;
  end;
 end;

 procedure OpenSession(aSessID, aUserID, aDate, aTime: DWORD);
 var
  l_Sess : TSessionData;
 begin
  if aUserID = usServerService then // сервер нам в статистике не нужен
   Exit;
  if (aUserID shr 24) = f_Region then // только пользователи определенного региона
  begin
   l3ZeroMemory(@l_Sess, SizeOf(TSessionData));
   l_Sess.rID := aSessID;
   l_Sess.rUserID := aUserID;
   l_Sess.rStartDate := aDate;
   l_Sess.rStartTime := aTime;
   l_Sess.rEndDate := aDate;
   l_Sess.rEndTime := aTime;
   l_SessList.Add(l_Sess);
  end;
 end;

 procedure CloseSessionPrim(aSess: PSessionData);
 var
  l_DT1: TStDateTimeRec;
  l_DT2: TStDateTimeRec;
  l_Days : Integer;
  l_Secs : Integer;
 begin
  if aSess <> nil then
  begin
   l_DT1.D := aSess.rStartDate;
   l_DT1.T := aSess.rStartTime;
   l_DT2.D := aSess.rEndDate;
   l_DT2.T := aSess.rEndTime;
   DateTimeDiff(l_DT1, l_DT2, l_Days, l_Secs);
   aSess.rWorkStat.rDuration := l_Days * SecondsInDay + l_Secs;
  end;
 end;

 procedure TouchSessionPrim(aSess: PSessionData; aDate, aTime: DWORD);
 begin
  aSess.rEndDate := aDate;
  aSess.rEndTime := aTime;
 end;

 procedure TouchSession(aSessionID, aDate, aTime: DWORD);
 var
  l_Sess: PSessionData;
 begin
  l_Sess := FindSession(aSessionID);
  if l_Sess <> nil then
   TouchSessionPrim(l_Sess, aDate, aTime);
 end;

 procedure AddPause(aSessID, aPause, aDate, aTime: DWORD);
 var
  l_Sess: PSessionData;
 begin
  l_Sess := FindSession(aSessID);
  if l_Sess <> nil then
  begin
   l_Sess.rWorkStat.rPauses := l_Sess.rWorkStat.rPauses + aPause;
   TouchSessionPrim(l_Sess, aDate, aTime);
  end;
 end;

 function ProcessLogRec(aRec : Pointer) : Boolean;
 var
  l_LogRec: PBBLogRec;
 begin
  Result := True; // нам нужны все записи
  l_LogRec := PBBLogRec(aRec);
  with l_LogRec^ do
   case TdaJournalOperation(Operation) of
    da_oobSessionBegin: OpenSession(Session, ExtID, Date, Time);
    da_oobPause       : AddPause(Session, AdditInfo, Date, Time);
    da_oobAutoClass   :
     begin
      Inc(l_ACCount);
      l_ACDocs := l_ACDocs + AdditInfo;
     end;
   else
    TouchSession(Session, Date, Time);
   end;
 end;

 function FindUser(aID: TdaUserID): TUserDataHolder;
 var
  I: Integer;
  l_CurUser: TUserDataHolder;
 begin
  Result := nil;
  for I := 0 to l_UserList.Count-1 do
  begin
   l_CurUser := TUserDataHolder(l_UserList.Items[I]);
   if l_CurUser.ID = aID then
   begin
    Result := l_CurUser;
    Break;
   end;
  end;
  if Result = nil then
  begin
   Result := TUserDataHolder.Create(aID, l_FromDate, l_DaysInStat);
   l_UserList.Add(Result);
   Result.Free;
  end;
 end;

 procedure CollectUsers;
  function ProcessSession(Data: PPointer; Index: Long): Bool;
  var
   l_Sess : PSessionData;
   l_User : TUserDataHolder;
   l_Stat: PWorkStatData;
   l_Idx: Integer;
  begin
   Result := True;
   l_Sess := PSessionData(Data^);

   // закончить сессию (вычислить ее продолжительность)
   CloseSessionPrim(l_Sess);

   // собираем статистику по дням
   l_Idx := l_Sess.rStartDate - l_FromDate;
   l_Stat := PWorkStatData(l_DayStats.ItemSlot(l_Idx));
   Inc(l_Stat^.rDuration, l_Sess.rWorkStat.rDuration);
   Inc(l_Stat^.rPauses, l_Sess.rWorkStat.rPauses);
   // распихиваем сессии по пользователям
   l_User := FindUser(l_Sess.rUserID);
   l_User.Sessions.Add(l_Sess);
   l_User.IncDurations(l_Sess.rWorkStat.rDuration, l_Sess.rWorkStat.rPauses);
   Inc(f_GlobalStats.rDuration, l_Sess.rWorkStat.rDuration);
   Inc(f_GlobalStats.rPauses,   l_Sess.rWorkStat.rPauses);
  end;
 begin
  l_SessList.IterateAllF(l3L2IA(@ProcessSession));
 end;

 procedure CollectStatsByUser;
  function CalcUserStatistic(Data: PUserDataHolder; Index: Long): Bool;
  begin
   Result := True;
   Data^.CalcDayByDayStats;
  end;
 begin
  l_UserList.IterateAllF(l3L2IA(@CalcUserStatistic))
 end;

 function PrintUserStats(Data: PUserDataHolder; Index: Long): Bool;
 begin
  Result := True;
  l_File.PutString(Format('Пользователь %d;', [Data^.ID]));
  Data^.PrintStats(l_File);
  l_File.PutString(FormatWorkStats(Data^.TotalDuration, Data^.TotalPauses));
  l_File.PutEndOfLine;
 end;

 function PrintOneDay(Data: PPointer; Index: Long): Bool;
 var
  l_Stat: PWorkStatData;
 begin
  Result := True;
  l_Stat := PWorkStatData(Data^);
  l_File.PutString(FormatWorkStats(l_Stat^.rDuration, l_Stat^.rPauses)+';');
 end;

begin
 l_Tbl := TdtTable.CreateWithOpen(f_PathToExe, 'corvax', 'BB_LOG', 0);
 try
  l_Sab := MakeSab(l_Tbl);
  Screen.Cursor := crHourGlass;
  try
   l_FromDate := DateTimeToStDate(deFrom.Date);
   l_ToDate := DateTimeToStDate(deTo.Date);
   l_DaysInStat := l_ToDate - l_FromDate + 1;
   l_Sab.Select(bbDate, l_FromDate, l_ToDate);
   if l_Sab.Count > 0 then
   begin
    l_Sab.Sort([bbDate, bbTime]);
    l_SessList := Tl3RecList.Create(SizeOf(TSessionData));
    try
     l_DayStats := Tl3RecList.Create(SizeOf(TWorkStatData));
     try
      l_ACCount := 0;
      l_ACDocs  := 0;
      l_DayStats.Count := l_DaysInStat;
      l_Iter := L2RecAccessProc(@ProcessLogRec);
      try
       l_Sab.IterateRecords(l_Iter, []);
      finally
       FreeRecAccessProc(l_Iter);
      end;
      l_UserList := Tl3ObjectRefList.Make;
      try
       l3ZeroMemory(@f_GlobalStats, SizeOf(f_GlobalStats));
       CollectUsers;
       CollectStatsByUser;
       l_File := Tl3TextStream.Create(feResultFile.FileName, l3_fmCreateReadWrite);
       with l_File do
       try
        PutLine('Регион:;'+cbRegion.Text);
        PutLine('Период:;'+l3DateToStr(l_FromDate)+' - '+l3DateToStr(l_ToDate));
        PutEndOfLine;
        Format('Автоклассификаций за период:; %d (документов: %d)', [l_ACCount, l_ACDocs]);
        PutEndOfLine;
        PutEndOfLine;
        PutString(';');
        for I := l_FromDate to l_ToDate do
         PutString(l3DateToStr(I)+';');
        PutString('ИТОГО');
        PutEndOfLine;
        l_UserList.IterateAllF(l3L2IA(@PrintUserStats));
        PutString('ИТОГО;');
        l_DayStats.IterateAllF(l3L2IA(@PrintOneDay));
        PutString(FormatWorkStats(f_GlobalStats.rDuration, f_GlobalStats.rPauses));
        PutEndOfLine;
       finally
        l3Free(l_File);
       end;
       Screen.Cursor := crDefault;
       MessageDlg('Статистика успешно собрана', mtInformation, [mbOK], 0);
      finally
       l3Free(l_UserList);
      end;
     finally
      l3Free(l_DayStats);
     end;
    finally
     l3Free(l_SessList);
    end;
   end;
  finally
   Screen.Cursor := crDefault;
   l_Sab := nil;
  end;
 finally
  l3Free(l_Tbl);
 end;
end;

constructor TUserDataHolder.Create(anID: TdaUserID; aStatStartDate: TStDate; aStatDaysCount: Integer);
begin
 inherited Create(nil);
 f_ID := anID;
 f_DateFrom := aStatStartDate;
 f_Sessions := Tl3DataPtrList.Make;
 f_Stats := Tl3RecList.Create(SizeOf(TWorkStatData));
 f_Stats.Count := aStatDaysCount;
end;

procedure TUserDataHolder.CalcDayByDayStats;
 function ProcessSession(Data: PPointer; Index: Long): Bool;
 var
  l_Sess : PSessionData;
  l_Stat : PWorkStatData;
  l_Idx  : Integer;
 begin
  Result := True;
  l_Sess := PSessionData(Data^);
  l_Idx := l_Sess.rStartDate - f_DateFrom;
  l_Stat := PWorkStatData(f_Stats.ItemSlot(l_Idx));
  Inc(l_Stat^.rDuration, l_Sess.rWorkStat.rDuration);
  Inc(l_Stat^.rPauses, l_Sess.rWorkStat.rPauses);
 end;
begin
 f_Sessions.IterateAllF(l3L2IA(@ProcessSession));
end;

procedure TUserDataHolder.Cleanup;
begin
 l3Free(f_Sessions);
 l3Free(f_Stats);
 inherited;
end;

procedure TUserDataHolder.IncDurations(aDuration, aPauses: Integer);
begin
 Inc(f_TotalDuration, aDuration);
 Inc(f_TotalPauses, aPauses);
end;

procedure TUserDataHolder.PrintStats(aText: Tl3TextStream);
 function PrintOneDay(Data: PPointer; Index: Long): Bool;
 var
  l_Stat: PWorkStatData;
 begin
  Result := True;
  l_Stat := PWorkStatData(Data^);
  aText.PutString(FormatWorkStats(l_Stat^.rDuration, l_Stat^.rPauses)+';');
 end;

begin
 f_Stats.IterateAllF(l3L2IA(@PrintOneDay));
end;

end.

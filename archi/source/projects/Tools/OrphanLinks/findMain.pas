unit findMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, dt_Sab, dtIntf, m3DBInterfaces,
  ComCtrls, l3Types, DT_Types, l3LongintList, l3Filer,

  daTypes, daInterfaces,

  OrphanFixFilter;

type
  TMainForm = class(TForm, IdaLongProcessSubscriber)
    gbFind: TGroupBox;
    rbSearchAll: TRadioButton;
    rbSearchInList: TRadioButton;
    feList: TFilenameEdit;
    btnDoWork: TButton;
    ProgressBar: TProgressBar;
    rbFix: TRadioButton;
    feFixDocList: TFilenameEdit;
    feFixRules: TFilenameEdit;
    lblFixRulesFile: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnDoWorkClick(Sender: TObject);
    procedure rbSearchAllClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Prvate declarations }
    f_DB: Im3DB;
    f_LostDocs: Tl3LongintList;
    f_OFiler: Tl3DOSFiler;
    function AllDocsList: Im3DBRange;
    procedure DoFindInAll;
    procedure DoFix;
    procedure GotOneOrphan(aDocID: Integer; aAddrDocID: Integer);
    procedure GotReplacedOneOrphan(const aCurDocID, aBadDocID, aRightDocID: TDocID);
    function DoLongProcessNotify(aState : TdaProcessState): Boolean;
    procedure LoadRules(const aFileName: AnsiString; aRulesList: TOrphanedPairList);
    procedure LoadTopicList(const aFileName: AnsiString; const aDocList: Tl3LongintList);
    function LongintList2Range(const aList: Tl3LongintList): Im3DBRange;
    procedure RefreshControls;
    function Sab2Range(aSab: ISab): Im3DBRange;
    procedure TotalProgress(aState: Byte; aValue: Long; const aMsg: String = '');
    procedure Yield(Sender: TObject);
  protected
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 l3Interfaces,
 l3FileUtils,
 l3LongintListPrim,
 l3Base,
 l3String,
 m3StorageInterfaces,
 m3StorageElementIDList,
 m3DB,
 DT_Serv,
 DT_Const,
 DT_Doc,
 k2TagGen,
 ddClientBaseEngine,
 vtDebug,
 ddUtils,

 daDataProvider,

 OrphanFindFilter
 ;
{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
 GlobalDataProvider.SubscribeLongProcess(Self);
end;

function TMainForm.AllDocsList: Im3DBRange;
var
 l_Sab: ISab;
begin
 l_Sab:= MakeAllRecords(DocumentServer(CurrentFamily).FileTbl);
 l_Sab.ValuesOfKey(fID_fld);
 Result:= Sab2Range(l_Sab);
end;

procedure TMainForm.btnDoWorkClick(Sender: TObject);
begin
 if rbSearchAll.Checked then
  DoFindInAll;
 if rbFix.Checked then
  DoFix; 
end;

procedure TMainForm.DoFindInAll;
var
 I: Integer;
 l_Filer: Tl3DOSFiler;
 l_Range : Im3DBRange;
 l_Time  : Cardinal;
 l_Filter: Tk2TagGenerator;
begin
 btnDoWork.Enabled := False;
 try
  f_DB := Tm3DB.Make(ConcatDirName(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily), 'bserv001'), Yield, nil, TotalProgress);

  try
   f_LostDocs := Tl3LongintList.MakeSorted;
   try
    //l_Time := dbgStartTimeCounter;
    if rbSearchAll.Checked then
     l_Range := AllDocsList
    else
     Assert(False, 'Not implemented');
    l_Filter := nil;
    TOrphanFindFilter.SetTo(l_Filter);
    TOrphanFindFilter(l_Filter).OnReportOrphan := GotOneOrphan;
    try
     l3System.Msg2Log('');
     l3System.Msg2Log('Начат поиск "потеряных" ссылок');
     f_OFiler := Tl3DOSFiler.Make(GetAppFolderFileName('OrphanLinks.txt'), l3_fmWrite);
     try
      f_OFiler.Open;
      f_OFiler.Writeln(Format('%10s %10s', ['Топик','ID документа']));
      l_Range.Iterate(l_Filter, False, [m3_dsMain]);
     finally
      FreeAndNil(f_OFiler);
     end;
    finally
     FreeAndNil(l_Filter);
    end;
    //l3System.Msg2Log(dbgFinishTimeCounter(l_Time, 'Range построен за %d мс'));
    l_Filer := Tl3DOSFiler.Make(GetAppFolderFileName('OrphanDocs.txt'), l3_fmWrite);
    try
     l_Filer.Open;
     for I := 0 to f_LostDocs.Count-1 do
      l_Filer.WriteLn(IntToStr(f_LostDocs[I]));
    finally
     FreeAndNil(l_Filer);
    end;
   finally
    FreeAndNil(f_LostDocs);
   end;
  finally
   f_DB := nil;
  end;
 finally
  btnDoWork.Enabled := True;
 end;
end;

procedure TMainForm.DoFix;
var
 l_DocList: Tl3LongintList;
 l_Range: Im3DBRange;
 l_RulesList: TOrphanedPairList;
 l_Filter: Tk2TagGenerator;
begin
 if not FileExists(feFixDocList.FileName) then
 begin
  MessageDlg('Неверно указан файл списка топиков для починки!', mtError, [mbOk], 0);
  FocusControl(feFixDocList);
  Exit;
 end;

 if not FileExists(feFixRules.FileName) then
 begin
  MessageDlg('Неверно указан файл правил исправления ссылок!', mtError, [mbOk], 0);
  FocusControl(feFixRules);
  Exit;
 end;

 l_DocList := Tl3LongintList.MakeSorted;
 try
  LoadTopicList(feFixDocList.FileName, l_DocList);
  if l_DocList.Count = 0 then
  begin
   MessageDlg('Список топиков пуст!', mtError, [mbOk], 0);
   Exit;
  end;
  l_RulesList := TOrphanedPairList.Create;
  try
   LoadRules(feFixRules.FileName, l_RulesList);
   if l_RulesList.Count = 0 then
   begin
    MessageDlg('Правила исправлений ссылок отсутствуют!', mtError, [mbOk], 0);
    Exit;
   end;

   // данные загружены, начинаем чинить

   btnDoWork.Enabled := False;
   try
    f_DB := Tm3DB.Make(ConcatDirName(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily), 'bserv001'), Yield, nil, TotalProgress);
    try
     //l_Time := dbgStartTimeCounter;
     l_Range := LongintList2Range(l_DocList);

     l_Filter := nil;
     TOrphanFixFilter.SetTo(l_Filter, l_RulesList);
     TOrphanFixFilter(l_Filter).OnReplace := GotReplacedOneOrphan;
     try
      l3System.Msg2Log('');
      l3System.Msg2Log('Начато исправление "потеряных" ссылок');
      l_Range.Iterate(l_Filter, True, [m3_dsMain]);
     finally
      FreeAndNil(l_Filter);
     end;
    finally
     f_DB := nil;
    end;
   finally
    btnDoWork.Enabled := True;
   end;
  finally
   FreeAndNil(l_RulesList);
  end;
 finally
  FreeAndNil(l_DocList);
 end;
end;

procedure TMainForm.GotOneOrphan(aDocID: Integer; aAddrDocID: Integer);
begin
 f_OFiler.Writeln(Format('%10d %10d', [aDocID, aAddrDocID]));
 f_OFiler.Flush;
 f_LostDocs.Add(aAddrDocID);
end;

procedure TMainForm.GotReplacedOneOrphan(const aCurDocID, aBadDocID, aRightDocID: TDocID);
begin
 l3System.Msg2Log('%10d: %d -> %d', [aCurDocID, aBadDocID, aRightDocID]);
end;

function TMainForm.DoLongProcessNotify(aState : TdaProcessState): Boolean;
begin
 Result := False;
 Application.ProcessMessages;
end;

procedure TMainForm.LoadRules(const aFileName: AnsiString; aRulesList: TOrphanedPairList);
var
 l_Filer: Tl3DOSFiler;
 l_Str: Tl3WString;
 l_From, l_To: Integer;
 l_Idx: Integer;
begin
 l_Filer := Tl3DOSFiler.Make(aFileName);
 try
  l_Filer.Open;
  while not l_Filer.EOF do
  begin
   l_Str := l3Trim(l_Filer.ReadLn);
   l_Idx := ev_lpCharIndex('=', l_Str);
   if l_Idx > 0 then
   begin
    l_From := l3StrToIntDef(l3Copy(l_Str, 0, l_Idx), 0);
    l_To   := l3StrToIntDef(l3Copy(l_Str, l_Idx+1, MaxInt), 0);
    if (l_From > 0) and (l_To > 0) then
     aRulesList.AddPair(l_From, l_To);
   end;
  end;
 finally
  FreeAndNil(l_Filer);
 end;
end;

procedure TMainForm.LoadTopicList(const aFileName: AnsiString; const aDocList: Tl3LongintList);
var
 l_Filer: Tl3DOSFiler;
 l_Idx: Integer;
 l_Str: Tl3WString;
 l_TopicNo: Integer;
begin
 l_Filer := Tl3DOSFiler.Make(aFileName);
 try
  l_Filer.Open;
  while not l_Filer.EOF do
  begin
   l_Str := l3Trim(l_Filer.ReadLn);
   l_Idx := ev_lpCharIndex(' ', l_Str);
   if l_Idx > 0 then
   begin
    l_Str := l3Copy(l_Str, 0, l_Idx);
    l_TopicNo := l3StrToIntDef(l_Str, 0);
    if l_TopicNo > 0 then
     aDocList.Add(l_TopicNo);
   end;
  end;
 finally
  FreeAndNil(l_Filer);
 end;
end;

procedure TMainForm.rbSearchAllClick(Sender: TObject);
begin
 RefreshControls;
end;

procedure TMainForm.RefreshControls;
begin
 feFixDocList.Enabled := rbFix.Checked;
 feFixRules.Enabled := rbFix.Checked;
 lblFixRulesFile.Enabled := rbFix.Checked;
 if rbFix.Checked then
  btnDoWork.Caption := 'Исправить'
 else
  btnDoWork.Caption := 'Найти';
end;


function TMainForm.LongintList2Range(const aList: Tl3LongintList): Im3DBRange;
var
 l_RangeList: Im3StorageElementIDList;
 i: Integer;
begin
 Result := nil;
 if aList.Count > 0 then
 begin
  l_RangeList := Tm3StorageElementIDList.MakeI;
  try
   for i:= 0 to aList.Hi do
    l_RangeList.Add(aList[i]);
   Result := f_DB.FilesInList(l_RangeList);
  finally
   l_RangeList:= nil;
  end;
 end;
end;


function TMainForm.Sab2Range(aSab: ISab): Im3DBRange;
var
 l_SabList: Tl3LongintList;
begin
 Result := nil;
 if aSab <> nil then
 begin
  l_SabList:= dtMakeSortedIDListBySab(aSab);
  try
   Result := LongintList2Range(l_SabList);
  finally
   FreeAndNil(l_SabList);
  end;
 end;
end;

procedure TMainForm.TotalProgress(aState: Byte; aValue: Long; const aMsg: String = '');
begin
 case aState of
  0: begin
      ProgressBar.Position:= 0;
      ProgressBar.Max:= aValue;
     end;
  1: begin
      ProgressBar.Position:= aValue;
     end; // aState = 1
  2: ProgressBar.Position:= ProgressBar.Max;
 end;
 Application.ProcessMessages;
end;

procedure TMainForm.Yield(Sender: TObject);
begin
 Application.ProcessMessages;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 GlobalDataProvider.UnSubscribeLongProcess(Self);
end;

end.

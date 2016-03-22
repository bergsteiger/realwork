{$A8,B-,C-,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O-,P+,Q+,R+,S-,T-,U-,V-,W+,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit MainForm;

{$I imexTest.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, ToolEdit, Mask, Buttons, Contnrs,

  l3IniFile,
  l3Base, l3StringList,
  dt_Types,
  dtIntf,
  dt_Sab,

  l3ObjectList;

type
  TTestForm = class(TForm)
    Panel1 : TPanel;
    btnGo : TButton;
    lblGlobalStatus: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure btnGoClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);

    procedure TopicEvent(aTopicNo: Longint; const aMessage: AnsiString);

    procedure FormShow(Sender: TObject);
    procedure wmShowMessage(var Message: TMessage); message wm_User + 12;

  private
    fFamily : TFamilyID;
    fNumSab : ISab;
    fSabFiller : IValueSetFiller;
    fWorkDir : String;
    f_FileList: TObjectList;
    f_StatusLeft: Integer;
    procedure BuildFileList;
    procedure CompareDifferent(Sender: TObject);
    function DoDeploy: Boolean;
    function DoImport: Boolean;
    procedure DoExport;
    procedure DoCompare;
  end;

var
  TestForm: TTestForm;


implementation

{$R *.DFM}

Uses
  HT_Const,
  dt_Doc,
  dt_LinkServ,
  dt_Renum,
  dt_AttrSchema,
  Dt_IFltr,
  l3FileUtils,
  ddClientBaseEngine,
  ddHTInit, ExportPipe,
  l3Types, l3Const,
  l3Stream,
  stDate, l3ExceptionsLog, afwVCL,
  ddPipeOutInterfaces,
  ddFileIterator,
  vtDebug,
  vtVerInf,
  JclMiscel, Math, ddImportPipe;

{.$Define OnlyExport} //Выключает импорт в отладочных целях

type
 TCompareStatus = (csEven, csDiffer, csMissing);

 TFileHolder = class
   f_FileName : string;
   f_NameLbl  : TLabel;
   f_StatusLbl: TLabel;
  private
   f_CompareBtn: TSpeedButton;
   f_CompareEvent: TNotifyEvent;
   f_Index: Integer;
  public
   constructor Create(aParent: TWinControl; aFilename: string; aTop: Integer; aIndex: Integer; aCompareHandler:
       TNotifyEvent);
   destructor Destroy; override;
   procedure SetCompareResult(aCompareStatus: TCompareStatus; aStatusLabelLeft: Integer; aParent: TWinControl);
  end;

resourcestring
  SHaveSomeErrors = 'Некоторые документы содержали ошибки. Вы хотите посмотреть список ошибок?';
  SErrorSetParams = 'Ошибка установки параметров';
  SUserPassword = 'UserPassword';
  SUserName = 'UserName';
  SUser = 'User';
  SFamilyPath = 'FamilyPath';

const
  cLabelsLeft = 14;


procedure TTestForm.FormCreate(Sender: TObject);
var
 CurDll      : TVersionInfo;
Begin
 CurDll:=TVersionInfo.Create(HTDLL);
 try
   l3System.Msg2Log('HyTech ver. %s', [CurDll.FileVersion]);
 finally
  FreeAndNil(CurDll);
 end;


 fWorkDir := ConcatDirName(ExtractFileDir(ParamStr(0)), 'data');
 if DoDeploy and InitBaseEngine(nil {aPromptUserPasswordProc},  True {aQuietMode}) then
 begin
  fFamily := 1;
  lblGlobalStatus.Caption := '';
  f_FileList := TObjectList.Create(True);
  BuildFileList;

  PostMessage(Handle, wm_User + 12, 0, 0);
 end
 else
  MessageDlg('Не удалось восстановить тестовое окружение', mtError, [mbOk], 0);
end;

function TTestForm.DoDeploy: Boolean;
begin
{$IfDef OnlyExport}
 Result:= True;
 Exit;
{$Else OnlyExport}

 DelDir(fWorkDir);
 if ForceDirectories(fWorkDir) then
 begin
  Result:= (WinExec32AndWait(PAnsiChar('rar x 0.rar *.* ' + fWorkDir + '\'), {SW_HIDE} SW_NORMAL) = 0) and
           (WinExec32AndWait(PAnsiChar('rar x in.rar *.* ' + ConcatDirName(fWorkDir, 'in\')), {SW_HIDE} SW_NORMAL) = 0);
  Result:= True;
 end
 else
  Result:= False;
{$EndIf OnlyExport}
end;

procedure TTestForm.FormDestroy(Sender: TObject);
begin
 f_FileList.Free;
 DoneClientBaseEngine;
end;

procedure TTestForm.CancelButtonClick(Sender: TObject);
begin
 close;
end;

procedure TTestForm.btnGoClick(Sender: TObject);
var
 lImpTime  : Cardinal;
 lExpTime  : Cardinal;

begin
 btnGo.Enabled := False;
 lblGlobalStatus.Caption := 'Выполняется импорт...';
 Application.ProcessMessages;
 lImpTime := dbgStartTimeCounter;
 if DoImport then
 begin
  lImpTime := dbgGetElapsed(lImpTime);

  lblGlobalStatus.Caption := 'Выполняется экспорт...';
  Application.ProcessMessages;

  lExpTime  := dbgStartTimeCounter;
  DoExport;
  lExpTime := dbgGetElapsed(lExpTime);

  lblGlobalStatus.Caption := 'Сравнение результатов...';
  Application.ProcessMessages;

  l3System.MemUsage2Log;
  DoCompare;
  l3System.Msg2Log('Время импорта : %d ms, время экспорта : %d ms,', [lImpTime, lExpTime]);
 end;
 btnGo.Enabled := True;
end;

procedure TTestForm.TopicEvent(aTopicNo: Longint; const aMessage: AnsiString);
begin
 if fSabFiller = nil then
  fSabFiller := fNumSab.MakeValueSetFiller(rnImportID_fld);
 fSabFiller.AddValue(aTopicNo);
end;

{$IfDef OnlyExport}
function TTestForm.DoImport: Boolean;
begin
 // выполняем за настоящий импорт работу по набивке списка
 Result := True;
 fNumSab := MakeSab(LinkServer(fFamily).Attribute[atRenum]);
 TopicEvent(20033333, '');
 TopicEvent(10000146, '');
 TopicEvent(10100300, '');
 TopicEvent(10101010, '');
 //TopicEvent(10101010, '');
 TopicEvent(12086270, '');
 TopicEvent(12186270, '');
 TopicEvent(11221122, '');
 TopicEvent(2072498, '');
 TopicEvent(44556677, '');
 TopicEvent(454545454, '');
 TopicEvent(555666, '');
 TopicEvent(999666, '');
  fSabFiller := nil;
 fNumSab.Refresh;
 fNumSab.ValuesOfKey(rnRealID_fld);
end;

{$ELSE OnlyExport}

function TTestForm.DoImport: Boolean;
begin
 with TddImportPipe.Create(fFamily) do
 try
  fNumSab := MakeSab(LinkServer(fFamily).Attribute[atRenum]);
  try
   InputFileType := dd_itGarant;
   OnTopicStart := TopicEvent;
   CheckDocuments:= False;
   //CheckDocuments := True;
   //SameDocuments := sdrDelete;
   //DeleteConditions := [dcIfNotVIncluded];

   NeedLockBase := True;
   WorkDir:= ConcatDirName(fWorkDir, 'in');
   PictureDir := WorkDir;
   NotUpdatableDicts:= [];//ddAllDicts;
   NeedFork:= True;
   UserID := 0;
   AddNewToLog := false;
   Result:= Execute;
  finally
   fSabFiller := nil;
   fNumSab.Refresh;
   fNumSab.ValuesOfKey(rnRealID_fld);
  end;
 finally
  Free;
 end; // try..finally
end;

{$EndIf OnlyExport}

procedure TTestForm.DoExport;
var
 l_Diapason: TDiapasonRec;
begin
   with TExportPipe.Create do
   try
    OutFileType := {outEVDtext; //}outNSRC;
    Family:= fFamily;
    DivideBy[edpDocument]   := [edbTopic];
    DivideBy[edpReference]  := [edbTopic];
    DivideBy[edpAnnotation] := [edbTopic];

    ExportDocument := True;
    ExportAnnotation := True;
    ExportDocImage := False;
    UpdateFiles := False;
    //ExternalExport := False;

    ExportEmpty := True;

    ExportKW := False;

    ExportDirectory := ConcatDirName(fWorkDir, 'out');

    // выборка
    //l_Diapason.Typ := tdNumList;
    //l_Diapason.List := fNumSab.htSab;
    //l_Diapason.ExternalFormat := False;
    //Diapason := l_Diapason;

    InternalFormat := false;
    DocSab := fNumSab;

    Execute;

    fNumSab:= nil;

   finally
    Free;
   end; {Pipe.Create}
end;

function l3CompareStreams(const aStream1, aStream2: TStream): Bool;
 {* - сравнивает побайтово два потока. }
var
 l_Size  : Long;
 l_Read  : Long;
 l_Buff1 : PChar;
 l_Buff2 : PChar;
begin
 if (aStream1 = aStream2) then
  Result := true
 else
 begin
  Result := false;
  if (aStream1 <> nil) AND (aStream2 <> nil) then
  begin
   l_Size := aStream1.Size - aStream1.Position;
   if (l_Size = aStream2.Size - aStream2.Position) then
   begin
    if (l_Size > 0) then
    begin
     l_Size := Min(l_Size, l3ParseBufSize);
     l3System.GetLocalMem(l_Buff1, l_Size);
     try
      l3System.GetLocalMem(l_Buff2, l_Size);
      try
       while true do
       begin
        l_Read := aStream1.Read(l_Buff1^, l_Size);
        if (l_Read <> aStream2.Read(l_Buff2^, l_Size)) then
         Exit; // - что-то не то с длинной

        if (l_Read = 0) then
        begin
         // - закончили читать
         Result := true;
         break;
        end;//l_Read = 0

        if not CompareMem(l_Buff1, l_Buff2, l_Size) then
         break;
         // - содержимое различается
       end;//while true
      finally
       l3System.FreeLocalMem(l_Buff2);
      end;//try..finally
     finally
      l3System.FreeLocalMem(l_Buff1);
     end;//try..finally
    end
    else
     Result := true;
   end;//l_Size = aStream2.Size
  end;//aStream1 <> nil
 end;//aStream1 = aStream2
end;


procedure TTestForm.BuildFileList;
var
 l_Iterator: TddFileIterator;
 l_Top: Integer;
 I: Integer;
 l_FileObj: TFileHolder;
begin
 l_FileObj := nil;
 f_FileList.Clear;
 l_Iterator := TddFileIterator.Make(ConcatDirName(fWorkDir, 'in'), '*.nsr');
 try
  l_Top := 40;
  f_StatusLeft := 0;
  for I := 0 to Pred(l_Iterator.FileList.Count) do
  begin
   l_FileObj := TFileHolder.Create(Self, ExtractFileName(l_Iterator.FileList[I]), l_Top, I, CompareDifferent);
   f_FileList.Add(l_FileObj);
   f_StatusLeft := Max(f_StatusLeft, cLabelsLeft + l_FileObj.f_NameLbl.Width + 7);
   Inc(l_Top, l_FileObj.f_NameLbl.Height + 5);
  end;
  ClientHeight := Panel1.Height + l_Top + 5;
 finally
  l3Free(l_Iterator);
 end;
end;

procedure TTestForm.CompareDifferent(Sender: TObject);
var
 l_Comparer: string;
 l_FN: string;
begin
 StationConfig.Section := 'Settings';
 l_Comparer := StationConfig.ReadParamFileNameDef('Differ', '');
 if (l_Comparer <> '') and FileExists(l_Comparer) then
 begin
   l_FN := TFileHolder(f_FileList[TSpeedButton(Sender).Tag]).f_FileName;
   WinExec32(Format('%s %s\in\%s %s\out\%s', [l_Comparer, fWorkDir, l_FN, fWorkDir, l_FN]), SW_NORMAL);
 end
 else
  if IsPositiveResult(MessageDlg('Не найдена программа сранения файлов. Хотите указать?', mtError, mbYesNoCancel, 0)) then
   if PromptForFileName(l_Comparer) then
   begin
    StationConfig.WriteParamStr('Differ', l_Comparer);
    CompareDifferent(Sender);
   end;
end;

procedure TTestForm.DoCompare;

 procedure StripHeader(aStream : TStream);
 var
  aCh : Char;
  aPos : Integer;
 begin
  aPos := 0;
  with aStream do
  begin
   while Position < Size do
   begin
    Read(aCh, 1);
    if aCh = '!' then break;
    while (Position < Size) and (aCh <> #10) do
     Read(aCh, 1);
    aPos := Position;
   end;
   Position := aPos;
  end;
 end;

var
 lStream1 : TStream;
 lStream2 : TStream;
 I: Integer;
 l_FName: string;
 l_FOutPath: string;

begin
 for I := 0 to f_FileList.Count-1 do
 begin
  l_FName := TFileHolder(f_FileList.Items[I]).f_FileName;
  l_FOutPath := ConcatDirName(fWorkDir, 'out\'+l_FName);
  if not FileExists(l_FOutPath) then
   TFileHolder(f_FileList.Items[I]).SetCompareResult(csMissing, f_StatusLeft, Self)
  else
  begin
   lStream1 := Tl3FileStream.Create(ConcatDirName(fWorkDir, 'in\'+l_FName), l3_fmRead);
   lStream2 := Tl3FileStream.Create(l_FOutPath, l3_fmRead);
   try
    StripHeader(lStream1);
    StripHeader(lStream2);

    if l3CompareStreams(lStream1, lStream2) then
     TFileHolder(f_FileList.Items[I]).SetCompareResult(csEven, f_StatusLeft, Self)
    else
     TFileHolder(f_FileList.Items[I]).SetCompareResult(csDiffer, f_StatusLeft, Self);
   finally
    l3Free(lStream1);
    l3Free(lStream2);
   end;
  end;
 end;
end;

constructor TFileHolder.Create(aParent: TWinControl; aFilename: string; aTop: Integer; aIndex: Integer; aCompareHandler: TNotifyEvent);
begin
 inherited Create;
 f_Filename := aFilename;
 f_NameLbl := TLabel.Create(aParent);
 f_NameLbl.Left := cLabelsLeft;
 f_NameLbl.Top := aTop;
 aParent.InsertControl(f_NameLbl);
 f_NameLbl.Caption := aFilename;
 f_Index := aIndex;
 f_CompareEvent := aCompareHandler;
end;

destructor TFileHolder.Destroy;
begin
 FreeAndNil(f_NameLbl);
 FreeAndNil(f_StatusLbl);
 FreeAndNil(f_CompareBtn);
 inherited;
end;

procedure TFileHolder.SetCompareResult(aCompareStatus: TCompareStatus;  aStatusLabelLeft: Integer; aParent: TWinControl);
begin
 if f_StatusLbl <> nil then
  FreeAndNil(f_StatusLbl);
 f_StatusLbl := TLabel.Create(aParent);
 f_StatusLbl.Left := aStatusLabelLeft;
 f_StatusLbl.Top := f_NameLbl.Top;
 aParent.InsertControl(f_StatusLbl);
 case aCompareStatus of
  csEven:
   begin
    f_StatusLbl.Caption := 'ОК';
    f_StatusLbl.Font.Color := clGreen;
   end;

  csDiffer:
   begin
    f_StatusLbl.Caption := 'Ошибка';
    f_StatusLbl.Font.Color := clMaroon;
    f_CompareBtn := TSpeedButton.Create(aParent);
    with f_CompareBtn do
    begin
     Caption := 'Сравнить...';
     //Font.Size := -9;
     Left := aStatusLabelLeft + f_StatusLbl.Width + 5;
     Width := 60;
     Height := f_StatusLbl.Height + 4;
     Top := f_StatusLbl.Top - 2;
     Flat := True;
     Tag := f_Index;
     OnClick := f_CompareEvent;
    end;
    aParent.InsertControl(f_CompareBtn);
   end;

  csMissing:
   begin
    f_StatusLbl.Caption := 'Отсутствует';
    f_StatusLbl.Font.Color := clRed;
   end;
 end;
end;

procedure TTestForm.FormShow(Sender: TObject);
begin
 //PostMessage(Handle, wm_User + 12, 0, LParam(lMRec));
 //Application.ProcessMessages;
 //btnGoClick(nil);
end;

procedure TTestForm.wmShowMessage(var Message: TMessage);
begin
 btnGoClick(nil);
end;
end.

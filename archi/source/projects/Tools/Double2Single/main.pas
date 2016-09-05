unit Main;

{ $Id: main.pas,v 1.7 2016/08/11 10:42:01 lukyanets Exp $ }

// $Log: main.pas,v $
// Revision 1.7  2016/08/11 10:42:01  lukyanets
// Полчищаем dt_user
//
// Revision 1.6  2016/05/18 06:02:42  lukyanets
// Выключаем удаленную отладку
//
// Revision 1.5  2015/07/02 11:41:06  lukyanets
// Описываем словари
//
// Revision 1.4  2015/04/07 07:35:57  lukyanets
// Изолируем HT
//
// Revision 1.3  2014/10/08 13:07:37  lukyanets
// Переносим процедуры в правильное место
//
// Revision 1.2  2012/02/29 10:15:48  lulin
// CheckFiler
//
// Revision 1.1  2011/02/25 09:51:42  narry
// К254354365. Утилита исправления двойных участников
//
// Revision 1.6  2010/08/02 15:29:00  fireton
// - удаление пустых строк в начале блока (K228692043)
//
// Revision 1.5  2010/07/01 15:20:04  narry
// - K222036156
//
// Revision 1.4  2010/06/10 15:11:48  fireton
// - пишем список реально обработанных документов в файл
//
// Revision 1.3  2010/06/02 10:09:12  fireton
// - объединяем поиск таблиц и моноширинных текстов и расстановку
//    разделов в них
//
// Revision 1.2  2010/04/16 12:42:03  fireton
// - выкидываем ненужную трубу
//
// Revision 1.1  2010/04/16 09:15:42  fireton
// - initial commit
//
// Revision 1.3  2010/04/15 14:45:15  fireton
// - доработка
//

interface

uses
  Windows, ActiveX, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OvcBase, l3Types,  W95Meter, ExtCtrls, Buttons,
  vtSpin, l3InterfacedComponent, m3DBInterfaces, Mask, ToolEdit,
  m3StorageInterfaces, daTypes,
  afwControlPrim, afwBaseControl, afwControl, XPMan, ComCtrls, csProcessTask, ddProgressObj,
  l3CustomString, DT_Types, DT_DictTypes, dt_AttrSchema, l3TempMemoryStream, DT_Sab;

type
  TMainForm = class(TForm)
    btWork: TButton;
    btStop: TButton;
    edBaseDir: TDirectoryEdit;
    pnStatus: TPanel;
    lbPercent: TLabel;
    Label1: TLabel;
    edTopicListFN: TFilenameEdit;
    lblTopicListFN: TLabel;
    XPManifest1: TXPManifest;
    Progress: TProgressBar;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btWorkClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    f_Stopped   : Bool;
    f_InProcess : Bool;
    f_NeedClose : Bool;
    f_DB        : Im3DB;
    f_Progressor: TddProgressObject;
    f_Start: TDateTime;
    f_Stream: Tl3TempMemoryStream;
    procedure DoWork;
    function ExportDocuments(const aSab: ISab; aProgressor: TddProgressObject): Boolean;
    function ImportDocuments(aProgressor: TddProgressObject): Boolean;
    function LoadDocNumbers(const aFileName: string): Im3StorageElementIDList;
    function  pm_GetBaseDir: String;
    procedure pm_SetBaseDir(const aValue: String);
    procedure ProcessUpdate(Sender: TObject; aState, aPercent: Integer);
    procedure TotalProgress(aState     : Byte; aValue     : Long; const aMsg : String = '');
      {-}
    procedure Yield(aSender: TObject);
    procedure _SkipDocument(aDocID : TDocID; WhyFlag : TSkipDocReason; UserID : Longint);
    procedure _StartTopic(aTopicNo: Longint; aMessage: String);
    function _UpdateDicts(aDictType: TdaDictionaryType; aDocID, aSubID: TSubID; aName: Tl3CustomString): Boolean;
      {-}
  public
    function LoadDocNumbers1: ISab;
    { Public declarations }
    property BaseDir: String
      read pm_GetBaseDir
      write pm_SetBaseDir;
      {-}
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  l3InternalInterfaces,
  l3Base,
  l3Filer,
  l3FileUtils,
  l3Parser,
  l3Stream,
  l3Memory,

  k2Types,
  k2Tags,
  k2TagGen,
  k2StackGenerator,

  m3DB,
  m3DBActions,
  m3StorageElementIDList,

  ddSectionRepair,

  evdReader,
  evdWriter,
  evEvdRd,

  ddUtils, L3Math, d2sFilter, ddLawCaseNameGenerator, dt_LinkServ, DT_const, ddHtInit, SewerPipe,
  ddImportPipe, ddImportPipeKernel, dt_IFltr, daInterfaces, daDataProvider, DT_Renum, DT_Doc,
  ddKTExtractor, l3LongintList;


procedure TMainForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_Progressor);
 FreeAndNil(f_Stream);
 SaveSettings(Self);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 LoadSettings(Self);
 f_Stream:= Tl3TempMemoryStream.Create;
 f_Progressor:= TddProgressObject.Create(nil);
 f_Progressor.OnUpdate:= ProcessUpdate;
end;

procedure TMainForm.btWorkClick(Sender: TObject);
var
 l_Total : TDateTime;

begin
 f_Stopped := false;
 f_InProcess := true;
 btWork.Enabled := false;
 btStop.Enabled := true;
 try
  l_Total := 0;
  try
   l3System.Msg2Log('Начало обработки');
   DoWork;
   if f_Stopped then
    l3System.Msg2Log('Обработка прервана пользователем')
   else
    l3System.Msg2Log('Обработка завершена');
  finally
   f_InProcess := false;
  end;//try..finally
 finally
  btWork.Enabled := true;
  btStop.Enabled := false;
 end;//try..finally
 pnStatus.Caption:= '';
 lbPercent.Caption:= '';
 if f_NeedClose then Close;
end;

procedure TMainForm.btStopClick(Sender: TObject);
begin
 f_Stopped := true;
 if (f_DB <> nil) then
  f_DB.Stop;
end;

procedure TMainForm.DoWork;
var
 l_Sab: ISab;
begin//DoWork
 pnStatus.Caption := 'Удаление дубликатов';
 if InitBaseEngine(BaseDir, 'guest', '') then
 try
  l_Sab:= LoadDocNumbers1;
  try
   f_Start:= Now;
   if ExportDocuments(l_Sab, f_Progressor) then
    ImportDocuments(f_Progressor);
  finally
   l_Sab:= nil;
  end;
  MessageDlg('Обработка завершена!', mtInformation, [mbOK], 0);
 finally
  DoneClientBaseEngine;
 end;
end;//DoWork

// 1553;1556;1653;1772;1773;1805;1806;1807;1808;1809;1810;1811;1812;1813;1814;1815;1816;1817;1818;1819
function TMainForm.ExportDocuments(const aSab: ISab; aProgressor: TddProgressObject): Boolean;
var
 l_OutPipe: TSewerPipe;
 l_Writer: Tk2TagGenerator;
 l_DR: TDiapasonRec;
 l_Sab: ISab;
 l_Stream: TFileStream;
 l_Filer: Tl3CustomFiler;
 l_List: Tl3LongintList;
begin
 // Экспортируем во временный файл
 l_OutPipe:= TSewerPipe.Create(nil);
 try
  l_OutPipe.Progressor:= aProgressor;
  l_OutPipe.ExportDocument:= True;
  l_DR.Typ:= tdNumList;
  DocumentServer.Family:= CurrentFamily;
  l_DR.List:= aSab.HTSab;
  l_DR.ExternalFormat:= False;
  l_DR.Choise:= 1;
  l_OutPipe.Diapason:= l_DR;

  l_Writer:= nil;
  try
   l_Filer:= Tl3CustomFiler.Create;
   try
    l_Filer.Stream:= f_Stream;
    TevdNativewriter.SetTo(l_Writer);
    TevdNativewriter(l_Writer).Filer:= l_Filer;
    l_List:= Tl3LongintList.Make;
    try
     with l_List do
     begin
      Add(1553);
      Add(1556);
      Add(1653);
      Add(1772);
      Add(1773);
      Add(1805);
      Add(1806);
      Add(1807);
      Add(1808);
      Add(1809);
      Add(1810);
      Add(1811);
      Add(1812);
      Add(1813);
      Add(1814);
      Add(1815);
      Add(1816);
      Add(1817);
      Add(1818);
      Add(1819);
     end;
     TddKTExtractorFilter.SetTo(l_Writer, ConcatDirname(BaseDir, 'garant\kthemes.zip'), l_List);
     Tdd_lcNameGenerator.SetTo(l_Writer);
     Td2sFilter.SetTo(l_Writer);
     l_OutPipe.Writer:= l_Writer;
     Result:= l_OutPipe.Execute;
    finally
     FreeAndNil(l_List);
    end;
   finally
    FreeAndNil(l_Filer);
   end;
  finally
   FreeAndNil(l_Writer);
  end;
 finally
  l3Free(l_OutPipe);
 end;
end;

function TMainForm.pm_GetBaseDir: String;
  {-}
begin
 Result := edBaseDir.Text;
end;

procedure TMainForm.pm_SetBaseDir(const aValue: String);
  {-}
begin
 edBaseDir.Text := aValue;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if f_InProcess then begin
  if (MessageDlg('Вы хотите прервать обработку?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
   f_NeedClose := true;
   f_Stopped := true;
   if (f_DB <> nil) then
    f_DB.Stop;
  end;
  CanClose := false;
 end;//f_InProcess
end;

function TMainForm.ImportDocuments(aProgressor: TddProgressObject): Boolean;
var
 l_InPipe: TddImportPipeFilter;
 l_Reader: TevEvdReader;
 l_Filer: Tl3CustomFiler;
begin
 l_InPipe:= TddImportPipeFilter.Create(CurrentFamily);
 try
  l_InPipe.UpdateTables:= False;
  l_InPipe.CheckDocuments:= False;
  l_InPipe.NeedLockBase:= False;
  l_InPipe.DocumentReaction:= sdrIgnore;
  l_InPipe.DeleteConditions := [dcAny];
  l_InPipe.InternalFormat:= False;
  l_InPipe.UserID:= usServerService;
  l_InPipe.OnTopicStart:= _StartTopic;
  l_InPipe.OnSkipDocument:= _SkipDocument;
  l_InPipe.OnDictionaryUpdate:= _UpdateDicts;
  l_Reader:= TevEvdReader.Create;
  try
   l_Filer:= Tl3CustomFiler.Create(nil);
   try
    l_Filer.Indicator.OnProgressProc:= aProgressor.Update;
    l_Filer.Indicator.NeedProgressProc:= True;
    f_Stream.Seek(0, 0);
    l_Filer.Stream:= f_Stream;
    l_Reader.Filer:= l_Filer;
    l_Reader.Generator:= l_InPipe;
    l_Reader.Execute;
   finally
    l3Free(l_Filer);
   end;
  finally
   l3Free(l_Reader);
  end;
 finally
  l3Free(l_InPipe);
 end;
end;

procedure TMainForm.Yield(aSender: TObject);
  {-}
begin
 Application.ProcessMessages;
end;

function TMainForm.LoadDocNumbers(const aFileName: string): Im3StorageElementIDList;
var
 lStream : Tl3FileStream;
 lTmpStream : Tl3MemoryStream;
 l_Parser    : Tl3Parser;
 l_CurNum    : Integer;

begin
 Result := nil;
 if FileExists(aFileName) then
 begin
  if InitBaseEngine(BaseDir, 'guest', '') then
  begin
   lStream := Tl3FileStream.Create(aFileName, l3_fmRead);
   try
    l_Parser := Tl3Parser.Create(nil);
    try
     l_Parser.CheckFloat := False;
     l_Parser.CheckFiler.Stream := lStream;
     l_Parser.NextTokenSp;
     while l_Parser.TokenType <> l3_ttEOF do
     begin
      if l_Parser.TokenType = l3_ttInteger then
      begin
       if Result = nil then
        Result := Tm3StorageElementIDList.MakeI;
       try
        l_CurNum := l_Parser.TokenInt;
        Result.Add(LinkServer(CurrentFamily).Renum.ConvertToRealNumber(l_CurNum));
       except
       end;
      end;
      l_Parser.Filer.ReadLn;
      l_Parser.NextTokenSp;
     end;
    finally
     l3Free(l_Parser);
    end;
   finally
    l3Free(lStream);
   end;
   DoneClientBaseEngine;
  end
 end;
end;

function TMainForm.LoadDocNumbers1: ISab;
var
 lStream     : Tl3FileStream;
 lTmpStream  : Tl3MemoryStream;
 lHasAdded   : Boolean;
 lVSFiller   : IValueSetFiller;
 l_Parser    : Tl3Parser;
 l_CurNum    : Integer;
 lIntNumber  : Boolean;
begin
 lHasAdded := False;
 lIntNumber := False;
 lStream := Tl3FileStream.Create(edTopicListFN.Text, l3_fmRead);
 try
  Result := MakeSab(LinkServer(CurrentFamily).Renum);
  lVSFiller := Result.MakeValueSetFiller(rnImportID_fld);
  try
   l_Parser := Tl3Parser.Create(nil);
   try
    l_Parser.CheckFloat := False;
    l_Parser.CheckFiler.Stream := lStream;
    l_Parser.NextTokenSp;

    if (l_Parser.TokenType = l3_ttSingleChar) and (l_Parser.TokenChar = '#') then
    begin
     l_Parser.Filer.ReadLn;
     l_Parser.NextTokenSp;
     lIntNumber := True;
    end;

    while l_Parser.TokenType <> l3_ttEOF do
    begin
     if l_Parser.TokenType = l3_ttInteger then
     begin
      try
       l_CurNum := l_Parser.TokenInt;
       lVSFiller.AddValue(l_CurNum);
      except
      end;
     end;
     l_Parser.Filer.ReadLn;
     l_Parser.NextTokenSp;
    end;
   finally
    l3Free(l_Parser);
   end;
  finally
   lVSFiller := nil;
  end;
 finally
  l3Free(lStream);
 end;

 if Result.isEmpty then Exit;

 if not lIntNumber then
  Result.ValuesOfKey(rnRealID_fld);
end;

procedure TMainForm.ProcessUpdate(Sender: TObject; aState, aPercent: Integer);
begin
 with TddProgressObject(Sender) do
 TotalProgress(TotalState, TotalPercent, TotalMessage);
end;

procedure TMainForm.TotalProgress(aState: Byte; aValue: Long; const aMsg: String = '');
begin
 pnStatus.Caption:= aMsg;
 case aState of
  0:
   begin
    Progress.Max:= aValue;
    Progress.Position:= 0;
    lbPercent.Caption := 'Приступаем к обработке...';
   end;
  1:
   begin
    Progress.Position:= aValue;
    if l3MulDiv(Progress.Position, 100, Progress.Max) > 0 then
     lbPercent.Caption := Format('Обработано %d%%, до окончания осталось %s',
       [Progress.Position, CalcLeftTime(Progress.Max, Progress.Position, f_Start, Now)])
    else
     lbPercent.Caption:= Format('Обработано %d%%',  [Progress.Position]);
   end;
  2:
   begin
    Progress.Position:= Progress.Max;
    lbPercent.Caption:= 'Обработка завершена';
   end;
 end;
 Application.ProcessMessages;
end;

procedure TMainForm._SkipDocument(aDocID : TDocID; WhyFlag : TSkipDocReason; UserID: Longint);
var
 aUserName,aLoginName : ShortString;
 aActFlag             : Byte;
 l_Msg: String;
begin
 if UserID > -1 then
  GlobalDataProvider.UserManager.GetUserInfo(UserID, aUserName, aLoginName, aActFlag);
  { Накапливаем сообщения о пропущенных документах }
 case WhyFlag of
  srUnknown       : l_Msg:= 'Причина неизвестна';
  srAlreadyExists : l_Msg:= Format('   #%d - существует в базе', [aDocID]);
  srBusy          : l_Msg:= Format('   #%d - занят пользователем %s', [aDocID, aUserName]);
  srCantBeDeleted : l_Msg:= Format('   #%d - не прошел проверку условий удаления', [aDocID]);
  srAccessDenied  : l_Msg:= 'Не удалось удалить исходный документ';
  srNoHandle      : l_Msg:= 'Не задан номер документа';
 end; // case WhyFlag
 l3System.Msg2Log(l_Msg);
end;

procedure TMainForm._StartTopic(aTopicNo: Longint; aMessage: String);
begin
end;

function TMainForm._UpdateDicts(aDictType: TdaDictionaryType; aDocID, aSubID: TSubID; aName:
    Tl3CustomString): Boolean;
begin
 Result:= True;
end;

end.
ddutils

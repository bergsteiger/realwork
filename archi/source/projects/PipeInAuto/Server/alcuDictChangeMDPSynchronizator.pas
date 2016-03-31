unit alcuDictChangeMDPSynchronizator;

// Модуль: "w:\archi\source\projects\PipeInAuto\Server\alcuDictChangeMDPSynchronizator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuDictChangeMDPSynchronizator" MUID: (55E6A67A02ED)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(MDPSyncIntegrated)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(Nemesis)}
 , dt_DictTypes
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Mutex
 , alcuTaskManager
 , daTypes
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 , l3BaseStream
 , l3Interfaces
 {$If NOT Defined(Nemesis)}
 , dt_DictConst
 {$IfEnd} // NOT Defined(Nemesis)
 , dt_Types
;

type
 PSourceSyncRec = ^TSourceSyncRec;

 TmssOperation = (
  ssoAll
  , ssoNew
  , ssoDel
  , ssoUpd
 );//TmssOperation

 TShortNameIndex = 1 .. dt_DictConst.cSourceShortNameLen;

 TSynonimsIndex = 1 .. dt_DictConst.cSourceSynonimsLen;

 TShortNameArray = array [TShortNameIndex] of AnsiChar;

 TSynonimsArray = array [TSynonimsIndex] of AnsiChar;

 TSourceSyncRec = record
  rID: TDictID;
  rShortName: TShortNameArray;
  rSynonims: TSynonimsArray;
 end;//TSourceSyncRec

 TalcuDictChangeMDPSynchronizator = class(Tl3ProtoObject{$If NOT Defined(Nemesis)}
 , IDictChangeNotifyRecipient
 {$IfEnd} // NOT Defined(Nemesis)
 )
  private
   f_Guard: Tl3Mutex;
   f_SyncFolder: AnsiString;
   f_TaskManager: TddServerTaskManager;
  private
   procedure PrepareDict(aDict: TdaDictionaryType;
    anOp: TmssOperation;
    const aSab: ISab = nil);
   procedure CreateXMLFile(aDict: TdaDictionaryType;
    anOp: TmssOperation;
    const aSab: ISab = nil);
   function CreateXMLStream(const aFolder: AnsiString;
    aDict: TdaDictionaryType;
    PurgeFolder: Boolean): Tl3Stream;
   procedure ExportSourcesToXML(aStream: Tl3Stream;
    aOperation: TmssOperation;
    const aSrcList: ISab);
   function HasDataToSend: Boolean;
   function GuardName: AnsiString;
   function SyncFolderMask: AnsiString;
   procedure ExportDictToXML(aDict: TdaDictionaryType;
    aStream: Tl3Stream;
    aOperation: TmssOperation;
    const aSrcList: ISab);
   procedure XMLGenerateRoot(const aXML: Il3XMLWriter;
    aDict: TdaDictionaryType;
    aOperation: TmssOperation);
   procedure XMLGenerateDelOperation(aDict: TdaDictionaryType;
    aStream: Tl3Stream;
    const aSrcList: ISab);
   procedure ExportPubSourcesToXML(aStream: Tl3Stream;
    aOperation: TmssOperation;
    const aSrcList: ISab);
   procedure XMLPutField(const aXML: Il3XMLWriter;
    const aName: AnsiString;
    const aData: AnsiString);
   procedure ExportTypesToXML(aStream: Tl3Stream;
    aOperation: TmssOperation;
    const aSrcList: ISab);
   procedure ExportSimpleDictToXML(aDict: TdaDictionaryType;
    aStream: Tl3Stream;
    aOperation: TmssOperation;
    const aSrcList: ISab);
  protected
   {$If NOT Defined(Nemesis)}
   procedure dcn_DictionaryChange(const Info: TDictMessageRec);
   {$IfEnd} // NOT Defined(Nemesis)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   procedure Start;
   procedure Stop;
   procedure UpdateSyncFolder;
   procedure SendDataThenReady(aTaskManager: TddServerTaskManager);
   procedure PrepareAllDicts;
 end;//TalcuDictChangeMDPSynchronizator
{$IfEnd} // Defined(AppServerSide) AND Defined(MDPSyncIntegrated)

implementation

{$If Defined(AppServerSide) AND Defined(MDPSyncIntegrated)}
uses
 l3ImplUses
 , dt_Const
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 , ddAppConfig
 , daSchemeConsts
 {$If NOT Defined(Nemesis)}
 , dt_Dict
 {$IfEnd} // NOT Defined(Nemesis)
 , l3FileUtils
 , l3Stream
 , l3Types
 , daDataProvider
 , l3XMLWriter
 , l3LongintList
 , l3String
 {$If Defined(ServerTasks)}
 , alcuMdpSyncDicts
 {$IfEnd} // Defined(ServerTasks)
 , daInterfaces
;

type
 TOperationMap = array [TmssOperation] of AnsiString;

const
 cMdpSourceSyncVersion = 4;
 c_mssOperationStr: TOperationMap = ('all', 'new', 'del', 'upd');
 c_SupportedDicts = [da_dlSources, da_dlTypes, da_dlCorSources];

constructor TalcuDictChangeMDPSynchronizator.Create;
//#UC START# *55E6B55B0261_55E6A67A02ED_var*
//#UC END# *55E6B55B0261_55E6A67A02ED_var*
begin
//#UC START# *55E6B55B0261_55E6A67A02ED_impl*
 inherited Create;
//#UC END# *55E6B55B0261_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.Create

procedure TalcuDictChangeMDPSynchronizator.Start;
//#UC START# *55E6B56F008D_55E6A67A02ED_var*
//#UC END# *55E6B56F008D_55E6A67A02ED_var*
begin
//#UC START# *55E6B56F008D_55E6A67A02ED_impl*
 DictServer(CurrentFamily).AddDictChangeNotifiedObj(Self);
 UpdateSyncFolder;
 PrepareAllDicts;
//#UC END# *55E6B56F008D_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.Start

procedure TalcuDictChangeMDPSynchronizator.Stop;
//#UC START# *55E6BC370138_55E6A67A02ED_var*
//#UC END# *55E6BC370138_55E6A67A02ED_var*
begin
//#UC START# *55E6BC370138_55E6A67A02ED_impl*
 DictServer(CurrentFamily).DelDictChangeNotifiedObj(Self);
//#UC END# *55E6BC370138_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.Stop

procedure TalcuDictChangeMDPSynchronizator.PrepareDict(aDict: TdaDictionaryType;
 anOp: TmssOperation;
 const aSab: ISab = nil);
//#UC START# *55E6FB200328_55E6A67A02ED_var*
//#UC END# *55E6FB200328_55E6A67A02ED_var*
begin
//#UC START# *55E6FB200328_55E6A67A02ED_impl*
 if f_Guard = nil then
  Exit;
 Assert(aDict in c_SupportedDicts);
 CreateXMLFile(aDict, anOp, aSab);
//#UC END# *55E6FB200328_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.PrepareDict

procedure TalcuDictChangeMDPSynchronizator.CreateXMLFile(aDict: TdaDictionaryType;
 anOp: TmssOperation;
 const aSab: ISab = nil);
//#UC START# *55E8091A01E5_55E6A67A02ED_var*
var
 l_Stream: Tl3Stream;
//#UC END# *55E8091A01E5_55E6A67A02ED_var*
begin
//#UC START# *55E8091A01E5_55E6A67A02ED_impl*
 l_Stream := CreateXMLStream(f_SyncFolder, aDict, anOp = ssoAll);
 try
  ExportDictToXML(aDict, l_Stream, anOp, aSab);
 finally
  FreeAndNil(l_Stream);
 end;
//#UC END# *55E8091A01E5_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.CreateXMLFile

function TalcuDictChangeMDPSynchronizator.CreateXMLStream(const aFolder: AnsiString;
 aDict: TdaDictionaryType;
 PurgeFolder: Boolean): Tl3Stream;
//#UC START# *55E80D38038B_55E6A67A02ED_var*
var
 l_Name: String;
 l_Counter: Integer;

const
 cNameMap: array [TdaDictionaryType] of String = (
  '',//   da_dlNone
  'docsrc',//   , da_dlSources
  'types', //   , da_dlTypes
  '',//   , da_dlClasses
  '',//   , da_dlKeyWords
  '',//   , da_dlBases
  '',//   , da_dlDateNums
  '',//   , da_dlWarnings
  '',//   , da_dlCorrects
  'pubsrc',//   , da_dlCorSources
  '',//   , da_dlPublisheds
  '',//   , da_dlPrefixes
  '',//   , da_dlTerritories
  '',//   , da_dlNorms
  '',//   , da_dlAccGroups
  '',//   , da_dlNewClasses_Deprecated
  '',//   , da_dlAnnoClasses
  '',//   , da_dlServiceInfo
  ''//   , da_dlTextInsert
 );

//#UC END# *55E80D38038B_55E6A67A02ED_var*
begin
//#UC START# *55E80D38038B_55E6A67A02ED_impl*
 f_Guard.Enter;
 try
  ForceDirectories(f_SyncFolder);
  if PurgeFolder then
   DeleteFilesByMask(f_SyncFolder, Format('*_%s.xml', [cNameMap[aDict]]));
  l_Counter := 0;
  repeat
   l_Name := ConcatDirName(f_SyncFolder, Format('%s%.4d_%s.xml', [FormatDateTime('yyyymmddhhnn', Now), l_Counter, cNameMap[aDict]]));
   inc(l_Counter);
  until not FileExists(l_Name);
  Result := Tl3FileStream.Create(l_Name, l3_fmWrite);
 finally
  f_Guard.Leave;
 end;
//#UC END# *55E80D38038B_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.CreateXMLStream

procedure TalcuDictChangeMDPSynchronizator.UpdateSyncFolder;
//#UC START# *55E822EE00F5_55E6A67A02ED_var*
var
 l_SyncFolder: String;
//#UC END# *55E822EE00F5_55E6A67A02ED_var*
begin
//#UC START# *55E822EE00F5_55E6A67A02ED_impl*
 l_SyncFolder := AnsiLowerCase(IncludeTrailingBackslash(ddAppConfiguration.AsString['dsSyncFolder']));
 if l_SyncFolder <> f_SyncFolder then
 begin
  f_SyncFolder := l_SyncFolder;
  FreeAndNil(f_Guard);
  if f_SyncFolder <> '' then
   f_Guard := Tl3Mutex.Create(GuardName);
 end;
//#UC END# *55E822EE00F5_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.UpdateSyncFolder

procedure TalcuDictChangeMDPSynchronizator.ExportSourcesToXML(aStream: Tl3Stream;
 aOperation: TmssOperation;
 const aSrcList: ISab);
//#UC START# *55E847E400CD_55E6A67A02ED_var*
var
 l_Sab: ISab;
 l_SC : ISabCursor;
 I : Integer;
 l_Src: PSourceSyncRec;
 l_XML: Il3XMLWriter;
 l_Path: AnsiString;
 l_SynsStr: Il3CString;

 function DoOneSynonim(const aStr: Tl3PCharLen; aIsLast: Bool): Bool;
 begin
  Result := True;
  l_XML.OpenSubLevel;
  try
   l_XML.PutData(l3Trim(aStr));
  finally
   l_XML.CloseLevel;
  end;
 end;
//#UC END# *55E847E400CD_55E6A67A02ED_var*
begin
//#UC START# *55E847E400CD_55E6A67A02ED_impl*
 Assert(aOperation <> ssoDel);

 if aOperation = ssoAll then
 begin
  l_Sab := MakeAllRecords(DictServer(CurrentFamily).DictTbl[da_dlSources]);
 end
 else
 begin
  l_Sab := MakeSabCopy(aSrcList);
  l_Sab.TransferToPhoto(dtIDFld, DictServer(CurrentFamily).DictTbl[da_dlSources]);
  l_Sab.RecordsByKey;
 end;

 l_XML := Tl3XMLWriter.Make(aStream);
 try
  // Генерируем начало XML
  XMLGenerateRoot(l_XML, da_dlSources, aOperation);
  try
   l_SC := l_Sab.MakeSabCursor([dtIDFld, dtShNameFld, dtSinonimsFld]);
   for I := 0 to Pred(l_SC.Count) do
   begin
    l_Src := l_SC.GetItem(I);
    l_Path := DictServer(CurrentFamily).Dict[da_dlSources].GetFullDictItemName(l_Src.rID, False);
    if l_Path <> '' then
    begin
     l_XML.OpenLevel('element', Format('id="%d"', [l_Src.rID]));
     try
      XMLPutField(l_XML, 'path', l_Path);
      XMLPutField(l_XML, 'short', l3ArrayToString(l_Src.rShortName, cSourceShortNameLen));
      l_XML.OpenLevel('syns');
      try
       l_SynsStr := l3ArrayToCString(l_Src.rSynonims, cSourceSynonimsLen);
       if not l3IsNil(l_SynsStr) then
        l3ParseWordsExF(l_SynsStr.AsWStr, l3L2WA(@DoOneSynonim), [';']);
      finally
       l_XML.CloseLevel; // syns
      end;
     finally
      l_XML.CloseLevel; // element
     end;
    end; // if l_Path <> ''
   end;
  finally
   l_XML.CloseLevel; // data
  end;
 finally
  l_XML := nil;
 end;
//#UC END# *55E847E400CD_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.ExportSourcesToXML

procedure TalcuDictChangeMDPSynchronizator.SendDataThenReady(aTaskManager: TddServerTaskManager);
//#UC START# *55ED481E007A_55E6A67A02ED_var*
var
 l_Task: TalcuMdpSyncDicts;
//#UC END# *55ED481E007A_55E6A67A02ED_var*
begin
//#UC START# *55ED481E007A_55E6A67A02ED_impl*
 if HasDataToSend then
 begin
  l_Task := TalcuMdpSyncDicts.Create(usServerService);
  try
   l_Task.SyncFolderMask := SyncFolderMask;
   l_Task.GuardName := GuardName;
   l_Task.Description := 'Синхронизация словарей в Гардок';
   if aTaskManager.ActiveTaskList.FindTask(l_Task.TaskType) = nil then
    aTaskManager.AddActiveTask(l_Task);
  finally
   FreeAndNil(l_Task);
  end;
 end;
//#UC END# *55ED481E007A_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.SendDataThenReady

function TalcuDictChangeMDPSynchronizator.HasDataToSend: Boolean;
//#UC START# *55ED484B0321_55E6A67A02ED_var*
//#UC END# *55ED484B0321_55E6A67A02ED_var*
begin
//#UC START# *55ED484B0321_55E6A67A02ED_impl*
 Result := l3FileUtils.FileExists(SyncFolderMask);
//#UC END# *55ED484B0321_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.HasDataToSend

function TalcuDictChangeMDPSynchronizator.GuardName: AnsiString;
//#UC START# *55ED50730160_55E6A67A02ED_var*
//#UC END# *55ED50730160_55E6A67A02ED_var*
begin
//#UC START# *55ED50730160_55E6A67A02ED_impl*
 Result := StringReplace(f_SyncFolder, '\', '|', [rfReplaceAll]);
//#UC END# *55ED50730160_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.GuardName

function TalcuDictChangeMDPSynchronizator.SyncFolderMask: AnsiString;
//#UC START# *55ED509D01AA_55E6A67A02ED_var*
//#UC END# *55ED509D01AA_55E6A67A02ED_var*
begin
//#UC START# *55ED509D01AA_55E6A67A02ED_impl*
 Result := f_SyncFolder + '*.xml';
//#UC END# *55ED509D01AA_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.SyncFolderMask

procedure TalcuDictChangeMDPSynchronizator.ExportDictToXML(aDict: TdaDictionaryType;
 aStream: Tl3Stream;
 aOperation: TmssOperation;
 const aSrcList: ISab);
//#UC START# *5605071B011C_55E6A67A02ED_var*
//#UC END# *5605071B011C_55E6A67A02ED_var*
begin
//#UC START# *5605071B011C_55E6A67A02ED_impl*
 if (aOperation = ssoAll) then
  Assert(aSrcList = nil)
 else
  Assert(aSrcList <> nil);
 if aOperation = ssoDel then
  XMLGenerateDelOperation(aDict, aStream, aSrcList)
 else
  case aDict of
   da_dlSources    : ExportSourcesToXML(aStream, aOperation, aSrcList);
   da_dlTypes      : ExportTypesToXML(aStream, aOperation, aSrcList);
   da_dlCorSources : ExportPubSourcesToXML(aStream, aOperation, aSrcList);
  else
   Assert(False);
  end;
//#UC END# *5605071B011C_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.ExportDictToXML

procedure TalcuDictChangeMDPSynchronizator.XMLGenerateRoot(const aXML: Il3XMLWriter;
 aDict: TdaDictionaryType;
 aOperation: TmssOperation);
//#UC START# *560507F403A2_55E6A67A02ED_var*
var
 l_DictName: AnsiString;
//#UC END# *560507F403A2_55E6A67A02ED_var*
begin
//#UC START# *560507F403A2_55E6A67A02ED_impl*
 case aDict of
  da_dlSources    : l_DictName := 'docsrc';
  da_dlTypes      : l_DictName := 'types';
  da_dlCorSources : l_DictName := 'pubsrc';
 else
  Assert(False);
 end;
 aXML.OpenLevel('data', Format('version="%d" region="%d" dict="%s" operation="%s"', [cMdpSourceSyncVersion,
    GlobalDataProvider.RegionID, l_DictName, c_mssOperationStr[aOperation]]));
//#UC END# *560507F403A2_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.XMLGenerateRoot

procedure TalcuDictChangeMDPSynchronizator.XMLGenerateDelOperation(aDict: TdaDictionaryType;
 aStream: Tl3Stream;
 const aSrcList: ISab);
//#UC START# *5605088602E0_55E6A67A02ED_var*
var
 l_XML: Il3XMLWriter;
 I: Integer;
 l_List: Tl3LongintList;
//#UC END# *5605088602E0_55E6A67A02ED_var*
begin
//#UC START# *5605088602E0_55E6A67A02ED_impl*
 l_XML := Tl3XMLWriter.Make(aStream);
 try
  XMLGenerateRoot(l_XML, aDict, ssoDel);
  try
   l_List := Tl3LongintList.Make;
   try
    dtCopyValuesSabToList(aSrcList, l_List);
    for I := 0 to Pred(l_List.Count) do
    begin
     l_XML.OpenLevel('element', Format('id="%d"', [l_List[I]]));
     l_XML.CloseLevel;
    end;
   finally
    FreeAndNil(l_List);
   end;
  finally
   l_XML.CloseLevel;
  end;
 finally
  l_XML := nil;
 end;
//#UC END# *5605088602E0_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.XMLGenerateDelOperation

procedure TalcuDictChangeMDPSynchronizator.ExportPubSourcesToXML(aStream: Tl3Stream;
 aOperation: TmssOperation;
 const aSrcList: ISab);
//#UC START# *560519400306_55E6A67A02ED_var*
//#UC END# *560519400306_55E6A67A02ED_var*
begin
//#UC START# *560519400306_55E6A67A02ED_impl*
 ExportSimpleDictToXML(da_dlCorSources, aStream, aOperation, aSrcList);
//#UC END# *560519400306_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.ExportPubSourcesToXML

procedure TalcuDictChangeMDPSynchronizator.XMLPutField(const aXML: Il3XMLWriter;
 const aName: AnsiString;
 const aData: AnsiString);
//#UC START# *56051FFF017E_55E6A67A02ED_var*
//#UC END# *56051FFF017E_55E6A67A02ED_var*
begin
//#UC START# *56051FFF017E_55E6A67A02ED_impl*
 aXML.OpenLevel(aName);
 try
  aXML.PutData(aData);
 finally
  aXML.CloseLevel;
 end;
//#UC END# *56051FFF017E_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.XMLPutField

procedure TalcuDictChangeMDPSynchronizator.PrepareAllDicts;
//#UC START# *560E41400242_55E6A67A02ED_var*
//#UC END# *560E41400242_55E6A67A02ED_var*
begin
//#UC START# *560E41400242_55E6A67A02ED_impl*
 PrepareDict(da_dlSources, ssoAll);
 PrepareDict(da_dlTypes, ssoAll);
 PrepareDict(da_dlCorSources, ssoAll);
//#UC END# *560E41400242_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.PrepareAllDicts

procedure TalcuDictChangeMDPSynchronizator.ExportTypesToXML(aStream: Tl3Stream;
 aOperation: TmssOperation;
 const aSrcList: ISab);
//#UC START# *561E342703DE_55E6A67A02ED_var*
//#UC END# *561E342703DE_55E6A67A02ED_var*
begin
//#UC START# *561E342703DE_55E6A67A02ED_impl*
 ExportSimpleDictToXML(da_dlTypes, aStream, aOperation, aSrcList);
//#UC END# *561E342703DE_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.ExportTypesToXML

procedure TalcuDictChangeMDPSynchronizator.ExportSimpleDictToXML(aDict: TdaDictionaryType;
 aStream: Tl3Stream;
 aOperation: TmssOperation;
 const aSrcList: ISab);
//#UC START# *561E38AE0112_55E6A67A02ED_var*
var
 l_Sab: ISab;
 l_SC : ISabCursor;
 I : Integer;
 l_XML: Il3XMLWriter;
 l_Path: AnsiString;
 l_DocID: PDocID;
//#UC END# *561E38AE0112_55E6A67A02ED_var*
begin
//#UC START# *561E38AE0112_55E6A67A02ED_impl*
 Assert(aOperation <> ssoDel);
 if aOperation = ssoAll then
 begin
  l_Sab := MakeAllRecords(DictServer(CurrentFamily).DictTbl[aDict]);
 end
 else
 begin
  l_Sab := MakeSabCopy(aSrcList);
  l_Sab.TransferToPhoto(dtIDFld, DictServer(CurrentFamily).DictTbl[aDict]);
  l_Sab.RecordsByKey;
 end;

 l_XML := Tl3XMLWriter.Make(aStream);
 try
  XMLGenerateRoot(l_XML, aDict, aOperation);
  try
   l_SC := l_Sab.MakeSabCursor([dtIDFld]);
   try
    for I := 0 to Pred(l_SC.Count) do
    begin
     l_DocID := l_SC.GetItem(I);
     l_Path := DictServer(CurrentFamily).Dict[aDict].GetFullDictItemName(l_DocID^, False);
     if l_Path <> '' then
     begin
      l_XML.OpenLevel('element', Format('id="%d"', [l_DocID^]));
      try
       XMLPutField(l_XML, 'path', l_Path);
      finally
       l_XML.CloseLevel;
      end;
     end;
    end;
   finally
    l_SC := nil;
   end;
  finally
   l_XML.CloseLevel;
  end;
 finally
  l_XML := nil;
 end;
//#UC END# *561E38AE0112_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.ExportSimpleDictToXML

{$If NOT Defined(Nemesis)}
procedure TalcuDictChangeMDPSynchronizator.dcn_DictionaryChange(const Info: TDictMessageRec);
//#UC START# *55E6B66A036E_55E6A67A02ED_var*
var
 l_Sab: ISab;
 l_Op: TmssOperation;
//#UC END# *55E6B66A036E_55E6A67A02ED_var*
begin
//#UC START# *55E6B66A036E_55E6A67A02ED_impl*
 if (Info.Family = CurrentFamily) and
    (Info.DictType in c_SupportedDicts) and
    (Info.Operation in [atAdd,atDelete,atEdit,atMove]) then
 begin
  l_Sab := MakeValueSet(DictServer(CurrentFamily).DictTbl[Info.DictType], dtIDFld, @Info.ID, 1);
  case Info.Operation of
   atAdd   : l_Op := ssoNew;
   atDelete: l_Op := ssoDel;
  else
   l_Op := ssoUpd;
  end;
  PrepareDict(Info.DictType, l_Op, l_Sab);
 end;
//#UC END# *55E6B66A036E_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.dcn_DictionaryChange
{$IfEnd} // NOT Defined(Nemesis)

procedure TalcuDictChangeMDPSynchronizator.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55E6A67A02ED_var*
//#UC END# *479731C50290_55E6A67A02ED_var*
begin
//#UC START# *479731C50290_55E6A67A02ED_impl*
 FreeAndNil(f_Guard);
 inherited;
//#UC END# *479731C50290_55E6A67A02ED_impl*
end;//TalcuDictChangeMDPSynchronizator.Cleanup
{$IfEnd} // Defined(AppServerSide) AND Defined(MDPSyncIntegrated)

end.

unit alcuAACImport;
{ Импорт постановлений }

interface

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

Uses
 Classes,

 l3Filer,
 l3LongintList,
 l3Types,
 l3Mutex,

 DT_types,

 ddProcessTaskPrim,
 ddFileIterator,
 ddProgressObj,

 csAACImport,
 csProcessTask,
 csTaskResult,
 {$If defined(ServerAssistantSide)}
 csDataPipe,
 {$Ifend defined(ServerAssistantSide)}

 alcuAACImportTaskResult
 ;

type
 TalcuAACImport = class(TcsAACImport)
 private
  f_Files: TddFileIterator;

  f_ProcessedFilesCount: Integer;
  f_UniqueCount: Integer;
  f_SkippedCount: Integer;
  f_DuplicateCount: Integer;
  f_EmptyCount: Integer;
  f_PrezidiumsCount: Integer;

  f_GeneralErrors: Tl3DOSFiler;
  f_LinksErrors: Tl3DOSFiler;
  f_Misspels: Tl3DOSFiler;
  f_Prezidiums: Tl3DOSFiler;
  f_TopicList: Tl3DOSFiler;
  f_Topics4Class: Tl3LongintList;
  f_CorrectedDocs: Tl3LongintList;

  f_CurrentDoc: String;
  f_CurrentFile: String;
  f_ArchiveFileName: String;
  f_CompressList: TStrings;

  f_Guard: Tl3Mutex;
  f_NeedTerminate: Boolean;

  function LogsFolder: String;
  function CheckFiles(const aFiles: TddFileIterator): Boolean;
  procedure PrepareReport(aSuccess: Boolean);
  function ImportFiles(const aProgressor: TddProgressObject; const aDocListFileName: string): Boolean;
  function pm_GetTaskResult: TalcuAACImportTaskResult;
  procedure MakeFileNameUnique(var theFileName: String);
  function GeneralErrorsFileName: string;
  function LinksErrorsFileName: string;
  function MisspelsFileName: string;
  function PrezidiumFileName: string;
  function WrongRelatedFileName: String;
  function TopicsFileName: string;
  procedure DeleteLogFiles;
  procedure DocSkipped(aDocID : TDocID; aReason: TSkipDocReason; User : LongInt);
  procedure MoveDuplicateFile;
  procedure ErrorReaction(const Msg: String; Category: Integer = 0);
  procedure OpenLogFiles;
  procedure CloseLogFiles;
  procedure GetFileName(var aFileName: String);
  procedure EmptyDocFound(Sender: TObject);
  procedure RepeatFound(aDocId: TDocID; aIsDuplicate: Boolean);
  function MaxFilesCount: Integer;
  function BackupFiles(aProgressor: TddProgressObject;
    aStart: Integer = 0; aFinish: Integer = -1): Boolean;
  procedure CompressFiles(aProgressor: TddProgressObject; aStart: Integer = 0; aFinish: Integer = -1);
  function DeleteFiles(const aFileName: String): Boolean;
  function PrepareCompressList(const aFileName: String): Boolean;
  procedure CheckRelated;
  procedure MarkCorrectedDocs;
  procedure TruncFileList(aCapacity: Integer);
  procedure MoveFiles(aFilesList: TStrings; const aFolder: String; aProgressProc: Tl3ProgressProc);
  procedure DoRunSuccessfullyFinishedImplementation;
 {$If defined(ServerAssistantSide)}
  procedure pipe_NeedTerminate(aPipe: TcsDataPipe);
 {$Ifend defined(ServerAssistantSide)}
  function NeedTerminate: Boolean;
 protected
  procedure DoRun(const aContext: TddRunContext); override;
  procedure DoAbort; override;
  function GetTaskResultClass: TcsTaskResultClass; override;
  {$If defined(AppServerSide)}
  procedure DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
  {$If defined(AppServerSide)}
  procedure RunEnded(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
 public
  class function CanAsyncRun: Boolean; override;
  function CanSimultaneousRunWith(const aTask: TddProcessTask): Boolean; override;
  constructor Create(aUserID: TUserID; aManualMode: Boolean); reintroduce;
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
  property TaskResult: TalcuAACImportTaskResult read pm_GetTaskResult;
 end;

implementation

uses
 SysUtils,
 Math,
 StrUtils,
 IniFiles,

 l3Base,
 l3FileUtils,
 l3Date,

 k2TagGen,
 k2BaseTypes,
 k2Tags,

 evEvdReader,
 evTagsListFilter,

 Document_Const,
 TextPara_Const,
 Task_Const,
 LeafPara_Const,

 daSchemeConsts,
 
 ddServerTask,
 {$If defined(AppServerSide)}
 ddAppConfig,
 {$IfEnd defined(AppServerSide)}
 ddImportPipeKernel,
 ddAutoLinkFilter,
 dd_lcResolutionFormatter,
 dd_lcJudgeFormatter,
 dd_lcClassOpenerFilter,
 ddKTExtractor,
 dd_lcDossierMaker,
 dd_lcDocIDGenerator,
 ddMisspellCorrect,
 dd_lcFileNameInserter,
 dd_lcTextChecker,
 dd_lcVASNameGenerator,
 dd_lcDateNumberFormatter,
 dd_lcCityNameFormatter,
 dd_lcTitleFormatter,
 dd_lcStartDocFormatter,
 dd_lcTextStyleCorrector,
 dd_lcTableEliminator,
 ddLawCaseNameGenerator,
 dd_lcSectionEliminator,
 ddSpaceTrimmer,
 dd_lcTextSplitter,
 dd_lcPageNumberEliminator,
 dd_lcBelongsGenerator,
 dd_lcDoublicateFilter,
 dd_lcVASCodeCorrector,
 dd_lcYearCodeCorrector,
 dd_lcTypeConverter,
 dd_lcSourceConverter,
 dd_lcVASSourceCorrector,
 ddUtils,
 ddAutolinkServer,
 ddAppConfigDataAdapters,
 dd_lcFASSourceCorrector,
 {$If defined(ServerAssistantSide)}
 csUserRequestManager,
 {$Ifend defined(ServerAssistantSide)}

 daInterfaces,
 dtIntf,
 dt_Const,
 dt_AttrSchema,
 dt_IFltr,
 dt_Doc,
 dt_Dict,
 Dt_LinkServ,
 dt_Sab,
 dt_UserConst,
 dt_TblCacheDef,
 dt_TblCache,

 csTaskTypes,
 csCourtDecisionSabCheckerParams,
 {$If defined(ServerAssistantSide)}
 csQueryTypes,
 {$Ifend defined(ServerAssistantSide)}

  {$If defined(AppServerSide)}
 alcuServer,
  {$IfEnd defined(AppServerSide)}
 alcuZipUtils,
 alcuMailServer,
 alcuUtils,
 alcuCourtDecisionListMaker,
{$IFDEF Courts}
 alcuCourtDecisionSubChecker,
{$ENDIF Courts}
 alcuSourceFilter
 ;

const
 catGeneral = 0;
 catLinks   = 1;
 catSpell   = 2;

 cMinFileSize = 100; // Минимальный размер файла, принимаемого в импорт

{ TalcuAACImport }

function TalcuAACImport.BackupFiles(aProgressor: TddProgressObject; aStart,
  aFinish: Integer): Boolean;
var
 l_Files: TddFileIterator;
 i: Integer;
begin
 Assert(CreatedByServer);
 l3System.Msg2Log('Архивирование и удаление исходных данных');
 ForceDirectories(DestinationFolder);
 l3System.Msg2Log('Архивирование исходных данных...');
 CompressFiles(aProgressor, aStart, aFinish);
 l3System.Msg2Log('Удаление исходных данных...');
 f_Files.IterateFiles(DeleteFiles, aStart, aFinish);
 l3System.Msg2Log('Архивирование и удаление завершены');
end;

class function TalcuAACImport.CanAsyncRun: Boolean;
begin
  Result := True;
end;

function TalcuAACImport.CheckFiles(const aFiles: TddFileIterator): Boolean;
begin
 Result:= not aFiles.Empty;
 if Result then
  l3System.Msg2Log('Найдено %d файлов исходных данных', [aFiles.FileList.Count])
 else
  l3System.Msg2Log('Исходные данные не найдены');
end;

procedure TalcuAACImport.CheckRelated;
var
 lSab: ISab;
 l_List : Tl3LongintList;
 l_S: TStrings;
 i: Integer;
begin
  l3System.Msg2Log('Проверка справок');
  DocumentServer.Family := CurrentFamily;
  lSab := MakeSab(DocumentServer.FileTbl);
  lSab.SelectAll;
  lSab.ValuesOfKey(fRelated_fld);
  lSab.RecordsByKey(fId_Fld);

  lSab.ValuesOfKey(fId_Fld);
  lSab.RecordsByKey(fRelated_fld);
  lSab.ValuesOfKey(fId_Fld);

  l_List := Tl3LongintList.Create;
  try
   dtCopyValuesSabToList(lSab, l_List);
   l_S:= TStringList.Create;
   try
    for i:= 0 to l_List.Hi do
     l_S.Add(IntToStr(l_List[i]));
    l_S.SaveToFile(WrongRelatedFileName);
   finally
    FreeAndNil(l_S);
   end;
  finally
   FreeAndNil(l_List);
  end;
 l3System.Msg2Log('Справки проверены');
end;

procedure TalcuAACImport.CloseLogFiles;
begin
 FreeAndNil(f_Topics4Class);
 FreeAndNil(f_CorrectedDocs);
 FreeAndNil(f_Prezidiums);
 FreeAndNil(f_Misspels);
 FreeAndNil(f_LinksErrors);
 FreeAndNil(f_GeneralErrors);
 FreeAndNil(f_TopicList);
end;

procedure TalcuAACImport.CompressFiles(aProgressor: TddProgressObject;
  aStart, aFinish: Integer);
begin
 f_CompressList:= TStringList.Create;
 try
  f_Files.IterateFiles(PrepareCompressList, aStart, aFinish);
  if not ZipFiles(f_ArchiveFileName, f_CompressList, aProgressor) then
   // Нужно скопировать файлы
   MoveFiles(f_CompressList, ExtractFileDir(f_ArchiveFileName), aProgressor.ProcessUpdate);
 finally
  FreeAndNil(f_CompressList);
 end;
end;

constructor TalcuAACImport.Create(aUserID: TUserID;
  aManualMode: Boolean);
const
 cDescMap: array [Boolean] of AnsiString = ('Импорт "сырых" постановлений', 'Импорт подготовленных постановлений');
begin
 inherited Create(aUserID);
 ManualMode := aManualMode;
 CreatedByServer := True;
 Description:= cDescMap[ManualMode];
end;

function TalcuAACImport.DeleteFiles(const aFileName: String): Boolean;
begin
 Result := True;
 DeleteFile(aFileName);
end;

procedure TalcuAACImport.DeleteLogFiles;
begin
 DeleteFile(GeneralErrorsFileName);
 DeleteFile(LinksErrorsFileName);
 DeleteFile(TopicsFileName);
 DeleteFile(MisspelsFileName);
 DeleteFile(PrezidiumFileName);
 DeleteFile(WrongRelatedFileName);
end;

procedure TalcuAACImport.DoAbort;
begin
 // Do nothing;
end;

procedure TalcuAACImport.DocSkipped(aDocID: TDocID;
  aReason: TSkipDocReason; User: Integer);
var
 l_Folder: String;
begin
 if aReason = srCantBeDeleted then
 begin
  if CreatedByServer then
    MoveDuplicateFile;
  Inc(f_SkippedCount);
 end
 else
  ErrorReaction('документ пропущен');
end;

procedure TalcuAACImport.DoRun(const aContext: TddRunContext);
var
 l_DocListFileName: String;
begin
 f_Guard := Tl3Mutex.Create('aacImport_'+ZippedLogsFolder);
 try
  l3System.Msg2log(Description);
  TaskResult.IsSuccess := False;
  l_DocListFileName:= ConcatDirName(LogsFolder, 'DocList20005.lst');
  f_Files:= TddFileIterator.Make(SourceDir, '*.evd');
  try
   if CheckFiles(f_Files) then
    TaskResult.IsSuccess := ImportFiles(aContext.rProgressor, l_DocListFileName)
   else
    PrepareReport(False);
  finally
   FreeAndNil(f_Files);
  end;
 finally
  FreeAndNil(f_Guard);
 end;
end;

  {$If defined(AppServerSide)}
procedure TalcuAACImport.DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices);
begin
 inherited;
 DoRunSuccessfullyFinishedImplementation;
end;
  {$IfEnd defined(AppServerSide)}

procedure TalcuAACImport.EmptyDocFound(Sender: TObject);
begin
 Inc(f_EmptyCount);
 if Pos('*', f_CurrentDoc) = 0 then
  Dec(f_UniqueCount)
 else
  Dec(f_DuplicateCount);
 f_GeneralErrors.Writeln(f_CurrentFile + ' без текста');
end;

procedure TalcuAACImport.ErrorReaction(const Msg: String;
  Category: Integer);
var
 l_Msg: String;
begin
 if Pos('*', f_CurrentDoc) = 0 then
 begin
  l_Msg:= IfThen(AnsiStartsStr(f_CurrentDoc, Msg), Msg, f_CurrentDoc + ': ' + Msg);
  case Category of
   1: f_LinksErrors.Writeln(l_Msg);
   2:
     begin
      f_Misspels.Writeln(l_Msg);
      f_CorrectedDocs.Add(StrToIntDef(f_CurrentDoc, cUndefDocID));
     end;
   10:
    begin
     f_Prezidiums.Writeln(Format('%s: %s', [f_CurrentDoc, f_CurrentFile]));
     Inc(f_PrezidiumsCount);
    end;
  else
  if f_GeneralErrors <> nil then
   f_GeneralErrors.Writeln(l_Msg)
  else
   l3System.Msg2Log(Msg);
  end;
 end;// Pos('*', f_CurrentDoc)
end;

function TalcuAACImport.GeneralErrorsFileName: string;
begin
 Result := ConcatDirName(LogsFolder, 'Format.log');
end;

procedure TalcuAACImport.GetFileName(var aFileName: String);
begin
 aFileName:= ExtractFileName(f_ArchiveFileName) + '\' + f_CurrentFile;
end;

function TalcuAACImport.GetTaskResultClass: TcsTaskResultClass;
begin
  Result := TalcuAACImportTaskResult;
end;

function TalcuAACImport.ImportFiles(const aProgressor: TddProgressObject;
  const aDocListFileName: string): Boolean;
var
 l_Reader: TevEvdStorageReader;
 l_Filer: TevDOSFiler;
 i, j, l_Count, l_Start: Integer;
 l_Gen: Tk2TagGenerator;
 l_R: Tdd_lcResolutionFormatter;
 l_J: Tdd_lcJudgeFormatter;
 l_SourceIDList: Tl3LongIntList;
 l_List: Tl3LongIntList;
 l_ImportFilter: TImportFilter;
{$IFDEF Courts}
 l_Params: TcsCourtDecisionSabCheckerParams;
{$ENDIF Courts}
begin
 l3System.Msg2Log('Импорт постановлений');
 Result := False;
 try
  l_Gen := TddImportPipeFilter.Create(CurrentFamily);
  try
   with TddImportPipeFilter(l_Gen) do
   begin
    UserID := usServerService;
    AddNewToLog := True;
    CheckDocuments := True;
    DeleteConditions := [dcIfNotVIncluded];
    DocumentReaction := sdrDelete;
    OnSkipDocument := DocSkipped;
    l_ImportFilter := ImportFilter;
    //BaseGenerator.ExclusiveMode:= True;
   end; //

   TddAutoLinkFilter.SetTo(l_Gen, nil, LinkDataFile);
   TddAutoLinkFilter(l_Gen).onError:= ErrorReaction;
   TddAutoLinkFilter(l_Gen).Category:= catLinks;

   Tdd_lcClassOpenerFilter.SetTo(l_Gen);

   l_SourceIDList := Tl3LongIntList.Create;
   try
    SourceIDList.ToList(l_SourceIDList);
    TddKTExtractorFilter.SetTo(l_Gen, KeyThemesFile, l_SourceIDList);
    TlcDossierMaker.SetTo(l_Gen, catGeneral, ErrorReaction);
    TlcDossierMaker(l_Gen).OnNewDocument:= TDocIDGenerator.GetNewDocID;
    l_List := Tl3LongintList.Create;
    try
      DossierSourceIDList.ToList(l_List);
      TlcDossierMaker(l_Gen).SourcesList:= l_List;
    finally
      FreeAndNil(l_List);
    end;
    TddMisspellCorrectFilterEx.SetTo(l_Gen, MisspellsFileName, catSpell, ErrorReaction);
    TalcuCourtDecisionListMaker.SetTo(l_Gen, aDocListFileName, catGeneral, ErrorReaction);
    Tdd_lcFileNameInserter.SetTo(l_Gen);
    Tdd_lcFileNameInserter(l_Gen).OnGetFileNameEvent:= GetFileName;
    TlcTextChecker.setTo(l_Gen); // DocumentFilter
    TlcTextChecker(l_Gen).OnEmptyDocument:= EmptyDocFound;
    if not ManualMode then
    begin
     Tdd_lcVASNameGenerator.SetTo(l_Gen, catGeneral, ErrorReaction);
     Tdd_lcJudgeFormatter.SetTo(l_Gen, catGeneral, ErrorReaction);
     l_J:= Tdd_lcJudgeFormatter(l_Gen);
     Tdd_lcResolutionFormatter.SetTo(l_Gen, catGeneral, ErrorReaction);
     l_R:= Tdd_lcResolutionFormatter(l_Gen);
     Tdd_lcDateNumberFormatter.SetTo(l_Gen, catGeneral, ErrorReaction);
     Tdd_lcCityFormatter.SetTo(l_Gen, catGeneral, ErrorReaction);
     l_R.AddBodyStartNotifier(Tdd_lcCityFormatter(l_Gen));
     Tdd_lcTitleFormatter.SetTo(l_Gen, catGeneral, ErrorReaction);
     Tdd_lcStartDocFormatter.SetTo(l_Gen, catGeneral, ErrorReaction);
     Tdd_lcTextStyleCorrector.SetTo(l_Gen, catGeneral, ErrorReaction);
     TlcTableEliminator2.SetTo(l_Gen);
     TlcTableEliminator2(l_Gen).OnError:= ErrorReaction;
     l_R.AddBodyStartNotifier(TlcTableEliminator2(l_Gen));
     l_J.AddBodyFinishNotifier(TlcTableEliminator2(l_Gen));
    end; // not aManual

    Tdd_lcNameGenerator.SetTo(l_Gen, catGeneral, ErrorReaction);

    if not ManualMode then
    begin
     if FASCorrectFileName <> '' then
      Tdd_lcFASSourceCorrector.SetTo(l_Gen, FASCorrectFileName);
     Tdd_lcSectionEliminator.SetTo(l_Gen);
     Tdd_lcSectionEliminator(l_Gen).OnError:= ErrorReaction;

     TddSpaceTrimmerFilter.SetTo(l_Gen);
     Tdd_lcTextSplitter.SetTo(l_Gen, #10);
     l_R.AddBodyStartNotifier(Tdd_lcTextSplitter(l_Gen));
     Tdd_lcPageNumberEliminator.SetTo(l_Gen, k2_idTextPara);
     Tdd_lcPageNumberEliminator(l_Gen).OnError:= ErrorReaction;
    end; // not  aManual

    TlcBelongsGenerator.SetTo(l_Gen, catGeneral, ErrorReaction);

    TlcDoublicateFilter.SetTo(l_Gen); // DocumentFilter
    TlcDoublicateFilter(l_Gen).OnError:= ErrorReaction;

    TDocIDGenerator.SetTo(l_Gen, catGeneral, ErrorReaction);
    with TDocIDGenerator(l_Gen) do
    begin
     l_List := Tl3LongintList.Create;
     try
       DocTypesIDList.ToList(l_List);
       TypesList:= l_List;
       l_List.Clear;
       FASSourceIDList.ToList(l_List);
       FASSourcesList:= l_List;
     finally
       FreeAndNil(l_List);
     end;
     SourcesList:= l_SourceIDList;
     OnNewDoc:= RepeatFound;
    end; // with TDocIDGenerator
    TalcuSourceDocFilter.SetTo(l_Gen, k2_idDocument, l_SourceIDList);
    TalcuSourceDocFilter(l_Gen).OnError:= ErrorReaction;
    Tdd_lcVASCodeCorrector.SetTo(l_Gen);
    Tdd_lcYearCodeCorrector.SetTo(l_Gen);
    Tdd_lcTypeConverter2.SetTo(l_Gen, catGeneral, ErrorReaction, SourceCOnvertFileName);
    Tdd_lcSourceConverterFilter.SetTo(l_Gen, SourceFileName);
    Tdd_lcTypeConverter.SetTo(l_Gen, catGeneral, ErrorReaction, TypeRecodeFileName);
    Tdd_lcVASSourceCorrector.SetTo(l_Gen);
    if not ManualMode then
     with TevTagsListFilter do
      SetTo(l_Gen, MakeAttrList(k2_typLeafPara, [k2_tiSegments]));
    TevEvdStorageReader.SetTo(l_Gen);
    l_Reader:= l_Gen as TevEvdStorageReader;
   finally
    FreeAndNil(l_SourceIDList);
   end;

   l_Filer:= TevDOSFiler.Create();
   try
    l_Reader.Filer:= l_Filer;
    l_Reader.Generator.Start;
    try
     //f_TopicList.Capacity:= f_Files.FileList.Count;
     try
      l_Filer.Indicator.NeedProgressProc:= True;
      l_Filer.Indicator.OnProgressProc:= aProgressor.ProcessUpdate;
      // нужно заливать кусочками (по заданному количеству файлов)
      l_Count:= f_Files.FileList.Count div MaxFilesCount;
      if f_Files.FileList.Count mod MaxFilesCount > 0 then
       Inc(l_Count);
      l_Start:= 0;
      for j:= 1 to l_Count do
      begin
       f_NeedTerminate := False;
       TaskResult.NeedRestart := j < l_Count;
       f_DuplicateCount:= 0;
       f_UniqueCount:= 0;
       f_SkippedCount:= 0;
       f_ProcessedFilesCount:= 0;
       f_EmptyCount:= 0;
       aProgressor.Start(l_Count, 'Импорт постановлений', False);
       if j > 1 then
        f_ArchiveFileName:= BaseArchiveName + Format('_%.3d.zip', [j])
       else
        f_ArchiveFileName:= BaseArchiveName + '.zip';
       OpenLogFiles;
       try
        // Импорт одного куска
        for i:= Pred(j)*MaxFilesCount to Pred(Min(MaxFilesCount*j, f_Files.FileList.Count)) do
        begin
         if not Aborted then
         begin
          f_CurrentFile:= ExtractFileName(f_Files.FileList.Strings[i]);
          l3System.Msg2Log('%d из %d %s', [Succ(i), f_Files.FileList.Count, f_CurrentFile]);
          if SizeOfFile(f_Files.FileList.Strings[i]) > cMinFileSize then
          begin
           if EnableOpenFile(f_Files.FileList.Strings[i]) then
           begin
            l_Filer.FileName:= f_Files.FileList.Strings[i];
            f_CurrentDoc:= '';
            l_Reader.Start;
            try
             l_Reader.Execute;
             Inc(f_ProcessedFilesCount);
            finally
             l_Reader.Finish;
            end;
           end
           else
            ErrorReaction('занят другим процессом');
          end
          else
          begin
           l3System.Msg2Log('пустой');
           Inc(f_EmptyCount);
          end;
          aProgressor.ProcessUpdate(Succ(i));
         end // not f_Aborted
         else
          break;
        end; // for i
        aProgressor.Stop;
        l_ImportFilter.DoneCachingData; // сбрасываем кэш в БД (чтобы каждый кусок был завершённым импортом)
        l_ImportFilter.StartCachingData;
        if CreatedByServer then
          BackupFiles(aProgressor, Pred(j)*MaxFilesCount, Min(MaxFilesCount*j, f_Files.FileList.Count));
        CheckRelated;
        MarkCorrectedDocs;
        //OpenClassification; <- выполняется в момент заливки
        {$IFDEF Courts}
        l_Params := TcsCourtDecisionSabCheckerParams.Create;
        try
          l_Params.SetTaggedData(CourtDecisionSabCheckerParams);
          TalcuCourtDecisionSubChecker.CheckInList(l_Params, aDocListFileName);
        finally
          FreeAndNil(l_Params);
        end;
        {$ENDIF}
       finally
        CloseLogFiles;
       end;
       PrepareReport(True);
       if NeedTerminate then
        break
       else
        DoRunSuccessfullyFinishedImplementation;
      end; // for j
     finally
      CleanupAutolinkServer;
     end;
     Result:= True;
    finally
     l_Reader.Generator.Finish;
    end; // Start..Finish
   finally
    l3Free(l_Filer);
   end;
  finally
   l3Free(l_Gen);
  end;
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;
 l3System.Msg2Log('Результат импорта: %s', [IfThen(Result, 'Успех', 'Ошибка')]);
end;

function TalcuAACImport.LinksErrorsFileName: string;
begin
 Result := ConcatDirName(LogsFolder, 'Links.log');
end;

function TalcuAACImport.LogsFolder: String;
begin
  Result := ConcatDirName(TaskFolder, 'Logs');
end;

procedure TalcuAACImport.MakeFileNameUnique(var theFileName: String);
var
 i: Integer;
 l_Template: String;
begin
 l_Template:= theFileName;
 i:= 1;
 while FileExists(theFileName) do
 begin
  theFileName:= ConcatDirName(ExtractFilePath(l_Template), ExtractOnlyFileName(l_Template)+'_'+IntToStr(i)+ExtractFileExt(l_Template));
  Inc(i)
 end; // while
end;

procedure TalcuAACImport.MarkCorrectedDocs;
var
 i: Integer;
 l_ID: Integer;
 l_Date: TstDate;
 l_Time: TstTime;
 l_User: TUserID;
 l_Value: TLogActionType;
begin
 l3System.Msg2Log('Пометка исправленных документов');
 l_Value:= acTextWork;
 l_Date:= CurrentDate;
 l_User:= usServerService;
 l_Time:= CurrentTime;
 with TCacheDirectAddAttrData.Create(CurrentFamily, ctLog_Doc) do
 try
  for i:= 0 to f_CorrectedDocs.Hi do
  begin
    l_ID:= f_CorrectedDocs[i];
    if l_ID <> cUndefDocID then
    begin
     l_ID:= LinkServer(CurrentFamily).Renum.ConvertToRealNumber(l_ID);
     if l_ID <> cUndefDocID then
     begin
      AddRecord([l_ID,           // DocID
                 Ord(l_Value),   // Action
                 l_Date,         // Date
                 l_Time,         // Time
                 Ord(acfOrdinal),// ActionFlag
                 'ALCU'#0,       // Station
                 l_User]);       // Author
     end; // l_ID <> cUndefDocID
    end; // l_ID <> -1
  end; // for i
 finally
  Free;
 end; // TCacheDirectAddAttrData.Create(CurrentFamily, ctStage)
 l3System.Msg2Log('Исправленные документы помечены');
end;

function TalcuAACImport.MaxFilesCount: Integer;
begin
  if CreatedByServer then
    Result := PartialLoadPackSize
  else
    Result := f_Files.FileList.Count;
end;

procedure TalcuAACImport.MoveDuplicateFile;
var
 l_Folder, l_Operation: String;
begin
 if CreatedByServer then
 begin
  ForceDirectories(DuplicatesFolder);
  l_Folder:= ConcatDirName(DuplicatesFolder, AnsiReplaceStr(f_CurrentDoc, '*', ''));
  ForceDirectories(l_Folder);
  try
   l_Operation:= 'копирования';
   CopyFilesByMask(SourceDir, l_Folder, ChangeFileExt(f_CurrentFile, '.*'));
   l_Operation:= 'удаления';
   DeleteFilesByMask(SourceDir, ChangeFileExt(f_CurrentFile, '.*'));
  except
   On E: Exception do
    l3System.Msg2Log('Ошибка %s файла %s: %s', [l_Operation, f_CurrentFile, E.message]);
  end;
 end;
end;

procedure TalcuAACImport.MoveFiles(aFilesList: TStrings;
  const aFolder: String; aProgressProc: Tl3ProgressProc);
var
 i: Integer;
begin
 for i:= 0 to Pred(aFilesList.Count) do
  CopyFileEx(aFilesList[i], ConcatDirName(aFolder, ExtractFileName(aFilesList[i])), aProgressProc, cmDeleteSource);
end;

procedure TalcuAACImport.OpenLogFiles;
begin
 f_TopicList:= Tl3DOSFiler.Make(TopicsFileName, l3_fmAppend);
 f_TopicList.Open;
 f_GeneralErrors:= Tl3DOSFiler.Make(GeneralErrorsFileName, l3_fmAppend);
 f_GeneralErrors.Open;
 f_LinksErrors:= Tl3DOSFiler.Make(LinksErrorsFileName, l3_fmAppend);
 f_LinksErrors.Open;
 f_Misspels:= Tl3DOSFiler.Make(MisspelsFileName, l3_fmAppend);
 f_Misspels.Open;
 f_Prezidiums:= Tl3DOSFiler.Make(PrezidiumFileName, l3_fmAppend);
 f_Prezidiums.Open;
 f_CorrectedDocs:= Tl3LongintList.Make;
 f_Topics4Class:= Tl3LongintList.Make;
end;

function TalcuAACImport.PrepareCompressList(
  const aFileName: String): Boolean;
begin
 Result := True;
 f_CompressList.Add(aFileName);
end;

procedure TalcuAACImport.RepeatFound(aDocId: TDocID;
  aIsDuplicate: Boolean);
begin
 f_CurrentDoc:= IntToStr(aDocID);
 if aIsDuplicate then
 begin
  Inc(f_DuplicateCount);
  f_TopicList.Writeln(f_CurrentDoc + '=*' + f_CurrentFile);
  f_CurrentDoc:= '*' + f_CurrentDoc;
  // MoveDuplicateFile; В этот момент файл открыт в ридере...
 end
 else
 begin
  f_TopicList.Writeln(f_CurrentDoc + '=' + f_CurrentFile);
  f_Topics4Class.Add(aDocId);
  Inc(f_UniqueCount);
 end;
end;

  {$If defined(AppServerSide)}
procedure TalcuAACImport.SetupServerSideConfigParams;
var
  l_Params: TcsCourtDecisionSabCheckerParams;
begin
 inherited;
 ForceDirectories(LogsFolder);
 if not CreatedByServer then
   SourceDir := TaskFolder;
 if CreatedByServer then
   BaseArchiveName := ConcatDirName(ddAppConfiguration.AsString['lcDestFolder'], DateToStr(Date))
 else
   BaseArchiveName := ConcatDirName(LogsFolder, 'AACImport_'+DateToStr(Date));
 MailToLog := ddAppConfiguration.asString['lcNotify'];

 if CreatedByServer then
   ZippedLogsFolder := ddAppConfiguration.AsString['lcArchive'] //GetAppFolderFileName('AAC Update Logs')
 else
   ZippedLogsFolder := LogsFolder;
 DuplicatesFolder := ddAppConfiguration.asString['lcDuplicateFolder'];
 LinkDataFile := ddAppConfiguration.AsString['lcLinkDataFile'];
 KeyThemesFile := ddAppConfiguration.AsString['lcKeyThemes'];
 SourceIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['lcSource']));
 DestinationFolder := ddAppConfiguration.AsString['lcDestFolder'];
 DossierSourceIDList.FromList(Tl3LongintList(ddAppCOnfiguration.AsObject['dosSource']));
 MisspellsFileName := ddAppCOnfiguration.AsString['lcMisspells'];
 FASCorrectFileName := ddAppCOnfiguration.AsString['lcFASCorrect'];
 DocTypesIDList.FromList(ddAppCOnfiguration.AsObject['lcType'] as Tl3LongintList);
 FASSourceIDList.FromList(ddAppCOnfiguration.AsObject['lcFASSource'] as Tl3LongintList);
 SourceCOnvertFileName := ddAppCOnfiguration.AsString['lcSourceConvertFile'];
 SourceFileName := ddAppCOnfiguration.AsString['lcSourceFile'];
 TypeRecodeFileName := ddAppCOnfiguration.AsString['lcTypeSyno'];
 PartialLoadPackSize := ddAppConfiguration.AsInteger['lcMaxFileCount'];
 l_Params := MakeCourtDecisionSabCheckerParams;
 try
   CourtDecisionSabCheckerParams := l_Params.TaggedData;
 finally
   FreeAndNil(l_Params);
 end;
 TaskCountBeforeRun := TalcuServer.Instance.TaskProcessor.AddedActiveTaskCount + 1;
end;
  {$IfEnd defined(AppServerSide)}

function TalcuAACImport.PrezidiumFileName: string;
begin
 Result := ConcatDirName(LogsFolder, 'Prezidium.log');
end;

function TalcuAACImport.MisspelsFileName: string;
begin
 Result := ConcatDirName(LogsFolder, 'Misspels.log');
end;

function TalcuAACImport.pm_GetTaskResult: TalcuAACImportTaskResult;
begin
  Result := TalcuAACImportTaskResult(inherited TaskResult);
end;

procedure TalcuAACImport.PrepareReport(aSuccess: Boolean);
var
 l_Msg: TStrings;
 l_A: TStrings;
 l_ZipFile: String;
 l_Y, l_M, l_D: Word;
 l_AttachOk: Boolean;
begin
{ TODO : Потом распилить на PrepareReport и собственно Send после выполнения задачи. }
 l3System.Msg2Log('Формирование отчета');
 if (f_Files <> nil) and (f_Files.FileList.Count > 0) then
 begin
  if ForceDirectories(ZippedLogsFolder) then
  begin
   DecodeDate(Date, l_Y, l_M, l_D);
   f_Guard.Enter;
   try
    l_ZipFile:= ConcatDirName(ZippedLogsFolder, Format('aac_update_%.2d-%.2d.zip', [l_M, l_D]));
    // проверить имя файла на уникальность
    MakeFileNameUnique(l_ZipFile);
    l_A:= TStringList.Create;
    try
     l_A.Add(GeneralErrorsFileName);
     l_A.Add(LinksErrorsFileName);
     l_A.Add(TopicsFileName);
     l_A.Add(MisspelsFileName);
     l_A.Add(PrezidiumFileName);
     l_A.Add(WrongRelatedFileName);
     l_AttachOk:= ZipFiles(l_ZipFile, l_A);
    finally
     FreeAndNil(l_A);
    end; // try..finally
   finally
    f_Guard.Leave;
   end;
  end; // ForceDirectories(ZippedLogsFolder)
  l_Msg:= TStringList.Create;
  try
   with l_Msg do
   begin
    if not aSuccess then
    begin
     Add('ВНИМАНИЕ! Импорт завершился с ошибкой.');
     Add('');
    end; // not aSuccess
    if not l_AttachOk then
    begin
     Add('ВНИМАНИЕ! Письмо не содержит лог-файлов. Обратитесь к администратору "Архивариуса"');
     Add('');
    end; // not aSuccess
    Add(Format('Обработано %d файлов из %d. В них найдено:', [f_ProcessedFilesCount, f_Files.FileList.Count]));
    Add(Format('  * %d уникальных документов, из них пропущено %d;', [f_UniqueCount, f_SkippedCount]));
    if CreatedByServer then
      Add(Format('  * %d повторов (%s);', [f_DuplicateCount, DuplicatesFolder]))
    else
      Add(Format('  * %d повторов;', [f_DuplicateCount]));
    Add(Format('  * %d пустых документов.', [f_EmptyCount]));
    Add('');
    Add(Format('Общие ошибки и ошибки форматирования находятся в файле %s,', [ExtractFileName(GeneralErrorsFileName)]));
    Add(Format('ошибки простановки ссылок - %s,', [ExtractFileName(LinksErrorsFileName)]));
    Add(Format('исправленные опечатки - %s,', [ExtractFileName(MisspelsFilename)]));
    Add(Format('список соответствия документов файлам - %s (повторы отмечены "*", документ №1 означает, что повторы относятся к ФАС),', [ExtractFileName(TopicsFileName)]));
    Add(Format('найденные документы Президиума ВАС (%d) - %s.', [f_PrezidiumsCount, ExtractFileName(PrezidiumFileName)]));
    Add('');
    Add('Неправильные справки (внутренние номера) перечислены в файле WrongRelated.txt');
   end; // with l_msg
   if l_AttachOk then
    TaskResult.AttachFileName := l_ZipFile;
   TaskResult.MailBody := l_Msg.Text;
   TaskResult.IsSuccess := aSuccess;
  finally
   FreeAndNil(l_Msg);
  end
 end
 else
 begin
  l3System.Msg2Log('Отправка отчета');
  TaskResult.MailBody := 'Исходные документы не найдены';
  TaskResult.IsSuccess := False;
 end;
end;

function TalcuAACImport.TopicsFileName: string;
begin
 Result := ConcatDirName(LogsFolder, 'Topics.log');
end;

procedure TalcuAACImport.TruncFileList(aCapacity: Integer);
begin
 while f_Files.FileList.Count > aCapacity do
  f_Files.FileList.Delete(Pred(f_Files.FileList.Count));
end;

function TalcuAACImport.WrongRelatedFileName: String;
begin
  Result := ConcatDirName(LogsFolder, 'WrongRelated.txt')
end;

function TalcuAACImport.CanSimultaneousRunWith(
  const aTask: TddProcessTask): Boolean;
begin
// Пока не будет полноценной параллельной работы + SourceFiles - отключаем.
//  Result := inherited CanSimultaneousRunWith(aTask);
//  if Result and (aTask is TalcuAACImport) then
//   Result := (Self = aTask) or ((TalcuAACImport(aTask).CreatedByServer = CreatedByServer) and CreatedByServer);
  Result := (aTask = Self) or (ClassName <> aTask.ClassName);
end;

  {$If defined(AppServerSide)}
procedure TalcuAACImport.RunEnded(const aServices: IcsRunTaskServices);
var
 l_Task: TalcuAACImport;
begin
 inherited;
 if Status = cs_tsDone then
 begin
  // Тут нужно попытаться обновить БД
  if CreatedByServer and TaskResult.NeedRestart then
  begin
   if (TalcuServer.Instance.TaskProcessor.AddedActiveTaskCount <> TaskCountBeforeRun) or
     {$IFDEF UseCommandFile}not TalcuServer.Instance.IsBaseFree(False){$ELSE}(not TalcuServer.Instance.DoUpdate(False)){$ENDIF} then
   begin
    TalcuServer.Instance.DoAutoClassify;
    l3System.Msg2Log('Прерывание импорта - на базе пользователи');
   end // not aServer.DoUpdate(False)
   else
   begin
     l_Task := TalcuAACImport.Create(usServerService, ManualMode);
     try
      l_Task.TaskFolder := Self.TaggedData.StrA[k2_attrTaskFolder];
      l_Task.SourceDir := Self.SourceDir;
      aServices.AddActiveTask(l_Task);
     finally
      FreeAndNil(l_Task);
     end;
   end;
  end
  else
  begin
   TalcuServer.Instance.DoAutoClassify;
   l3System.Msg2log('Импорт завершен');
  end;
 end; 
end;
  {$IfEnd defined(AppServerSide)}

procedure TalcuAACImport.DoRunSuccessfullyFinishedImplementation;
var
 l_A: TStringList;
begin
 l3System.Msg2Log('Отправка отчета');
 if TaskResult.AttachFileName <> '' then
 begin
   l_A:= TStringList.Create;
   l_A.Add(TaskResult.AttachFileName)
 end
 else
   l_A := nil;
 try
   alcuMail.SendEmail(MailToLog, TaskResult.MailBody, 'Обновление базы постановлений ААС', not TaskResult.IsSuccess, l_A);
 finally
   FreeAndNil(l_A);
 end;

 l3System.Msg2Log('Удаление лог-файлов');
 DeleteLogFiles;
end;

 {$If defined(ServerAssistantSide)}
procedure TalcuAACImport.pipe_NeedTerminate(aPipe: TcsDataPipe);
begin
 aPipe.WriteInteger(TaskCountBeforeRun);
 f_NeedTerminate := aPipe.ReadInteger = 1;
end;
 {$Ifend defined(ServerAssistantSide)}

function TalcuAACImport.NeedTerminate: Boolean;
begin
 {$If defined(ServerAssistantSide)}
 f_NeedTerminate := False;
 if not UserRequestManager.CSClient.Exec(qtalcuAACNeedTerminate, pipe_NeedTerminate) then
  f_NeedTerminate := True;
 Result := f_NeedTerminate;
 {$else}
 Result := TalcuServer.Instance.AACNeedTerminate(TaskCountBeforeRun)
 {$IfEnd defined(ServerAssistantSide)}
end;

initialization
 RegisterTaskClass(cs_ttAACImport, TalcuAACImport, 'Импорт постановлений');
end.

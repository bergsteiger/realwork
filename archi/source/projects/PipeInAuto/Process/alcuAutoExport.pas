unit alcuAutoExport;
{ Реализация запроса юристов на Автовыливку (Автоэкспорт)
  Исходные данные:

   * список групп доступа (документов)
   * дата версии (А)
   * дата изменения (Б)

  Выходные данные:
   1) Документы (режутся по 4000 кб):
    * подключенные в версию А - new%maim%.nsr, rel%main%1.nsr
    * изменившиеся с Б - %main%%number%.nsr, rel%main%2,nsr
   2) Аннотации (не режутся)
    * включенные в базу, измененные или импортированные с Б от всех пользователей - annotate.nsr
   3) Документы (режутся пл 4000 кб)
    * от ГД "Справочная и техническая информация" за весь период - info%number%.nsr

}

interface
{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

Uses
 Classes,  SysUtils,
 l3Base, l3LongintList,
 ExportPipe, ddProgressObj, evdDTTypes,
 dt_Query, dt_Types, dtIntf, DT_Sab,
 alcuAutoExportTaskPrim, alcuAutoExportTaskResult;

type
 TaeTotalCountEvent = procedure (aTotalCount: Integer) of object;

 TalcuAutoExporter = class(Tl3Base)
 private
  f_AccGr: TdtQuery;
  f_Anno: Integer;
  f_AnnoQuery: TdtQuery;
  f_ChangedDocs: Integer;
  f_Info: Integer;
  f_NewDocs: Integer;
  f_NotIncDocs: Integer;
  f_NewDocsQuery: TdtQuery;
  f_NotIncDocsQuery: TdtQuery;
  f_Now: TDateTime;
  f_OnCalculationDone: TepCalculationDone;
  f_OnTotalCount: TaeTotalCountEvent;
  f_Pipe: TExportPipe;
  f_ResQuery: TdtQuery;
  f_Aborted: Boolean;
  f_TaskParams: TalcuAutoExportTaskPrim;
  f_TaskResult: TalcuAutoExportTaskResult;
  procedure AddAccGroups(aReport: TStrings);
  procedure AddBases(aReport: TStrings);
  procedure AddFullGroups(aReport: TStrings);
  procedure AddQuery(aReport: TStrings);
  procedure BuildAndSaveList;
  procedure CalculateAnnotations;
  procedure CalculateChangedDocuments;
  procedure CalculateIncludedDocuments;
  procedure CalculateInfoDocuments;
  procedure CalculateNotIncludedDocuments;
  procedure ExecuteCommandFile;
  procedure ExportAnnotations;
  procedure ExportChangedDocuments;
  procedure ExportIncludedDocuments;
  procedure ExportInfoDocuments;
  procedure ExportNotIncludedDocuments;
  procedure CheckDates;
  procedure ExpandEditionsIfNeeded(var theQuery: TdtQuery);
  procedure PrepareReport(aStart: TDateTime);
  procedure WriteDoneFile;
  function GetCommandFileName(var aFileName, aWorkFolder, aParams: String): Boolean;
  function GetDocQuery: TdtQuery;
 protected
  procedure CalculateTotalCount;
 public
  constructor Create(const aParams: TalcuAutoExportTaskPrim; const aResult: TalcuAutoExportTaskResult);
  procedure Cleanup; override;
  procedure AbortProcess;
  procedure Execute(aProgressor: TddProgressObject);
  property OnCalculationDone: TepCalculationDone read f_OnCalculationDone write f_OnCalculationDone;
  property OnTotalCount: TaeTotalCountEvent read f_OnTotalCount write f_OnTotalCount;
 end;

implementation
Uses
 ht_dll, SavedQuery,
 daTypes,
 dt_SrchQueries, dt_const, dt_AttrSchema, Dt_Doc,
 l3Date, l3FileUtils, l3Stream, l3Types,
 ddUtils, alcuMailServer,
 dt_Dict, StrUtils, DT_Serv, DT_Link, DT_LinkServ, DT_Renum, HT_const, l3ShellUtils, ddPipeOutInterfaces;

constructor TalcuAutoExporter.Create(const aParams: TalcuAutoExportTaskPrim;
  const aResult: TalcuAutoExportTaskResult);
begin
 inherited Create;
 aParams.SetRefTo(f_TaskParams);
 aResult.SetRefTo(f_TaskResult);
 f_Pipe:= TExportPipe.Create{X};
 f_Pipe.Family := CurrentFamily;
 f_Pipe.LowcaseNames:= True;
 f_Pipe.OutFileType:= f_TaskParams.OutFormat;
 f_Pipe.OnlyStructure:= False;
end;

procedure TalcuAutoExporter.AddAccGroups(aReport: TStrings);
var
 i: Integer;
 l_List: Tl3LongintList;
begin
 aReport.Add('Документы Групп доступа');
 aReport.Add('');
 if f_TaskParams.AccGroupsIDList.Count > 0 then
 begin
  l_List := Tl3LongintList.Create;
  try
   f_TaskParams.AccGroupsIDList.ToList(l_List);
   for i:= 0 to l_List.Hi do
    aReport.Add(DictServer(CurrentFamily).Dict[{$IFDEF AEByBelongs}da_dlBases{$ELSE}da_dlAccGroups{$ENDIF}].GetFullDictItemName(l_List.Items[i]));
  finally
   FreeAndNil(l_List);
  end;
 end;
 aReport.Add('');
end;

procedure TalcuAutoExporter.AddBases(aReport: TStrings);
{$If not defined(LUK) AND not defined(SGC)}
var
 i: Integer;
 l_List: Tl3LongintList;
{$IfEnd not defined(LUK) AND not defined(SGC)}
begin
{$If not defined(LUK) AND not defined(SGC)}
 aReport.Add('Аннотации Групп документов');
 aReport.Add('');

 if f_TaskParams.BasesIDList.Count > 0 then
 begin
  l_List := Tl3LongintList.Create;
  try
   f_TaskParams.BasesIDList.ToList(l_List);
   for i:= 0 to l_List.Hi do
    aReport.Add(DictServer(CurrentFamily).Dict[da_dlBases].GetFullDictItemName(l_List.Items[i]));
  finally
   FreeAndNil(l_List);
  end;
 end;
 aReport.Add('');
{$Else not defined(LUK) AND not defined(SGC)}
 Assert(False);
{$IfEnd not defined(LUK) AND not defined(SGC)}
end;

procedure TalcuAutoExporter.AddFullGroups(aReport: TStrings);
var
 i: Integer;
 l_List: Tl3LongintList;
begin
 aReport.Add('Все документы Групп доступа');
 aReport.Add('');
 if f_TaskParams.InfoIDList.Count > 0 then
 begin
  l_List := Tl3LongintList.Create;
  try
   f_TaskParams.InfoIDList.ToList(l_List);
   for i:= 0 to l_List.Hi do
    aReport.Add(DictServer(CurrentFamily).Dict[{$IFDEF AEByBelongs}da_dlBases{$ELSE}da_dlAccGroups{$ENDIF}].GetFullDictItemName(l_List.Items[i]));
  finally
   FreeAndNil(l_List);
  end;
 end; 
 aReport.Add('');
end;

procedure TalcuAutoExporter.AddQuery(aReport: TStrings);
var
 i: Integer;
 l_List: Tl3LongintList;
begin
 aReport.Add('Документы, найденные поиском');
 aReport.Add('');
 { TODO : Хорошо бы сюда писать название поиска }
 aReport.Add('');
end;

procedure TalcuAutoExporter.BuildAndSaveList;
var
 l_Stream: TStream;

   function lp_SaveID(aItemPtr : Pointer): Boolean;
   var
    l_ID: String;
   begin
    Result:= True;
    if PLongint(aItemPtr)^ > 0 then
    begin
     l_ID:= IntToStr(PLongint(aItemPtr)^)+#13#10;
     l_Stream.Write(l_ID[1], Length(l_ID));
    end;
   end; // ExtractStr

var
 l_Rels: ISab;
 lStub : TdtRecAccessProc;
 l_Sab : ISab;
 l_Anno: ISab;
 l_Value: Integer;
begin
 l_Sab:= MakeEmptySab(MakePhoto(GlobalHtServer.GetTblObjectEx(CurrentFamily, Ord(ftFile))));;

 if aeIncluded in f_TaskParams.Stages then
  l_Sab.OrSab(f_NewDocsQuery.FoundList);
 if aeChanged in f_TaskParams.Stages then
  l_Sab.OrSab(f_ResQuery.FoundList);
 if aeInfo in f_TaskParams.Stages then
  l_Sab.OrSab(f_AccGr.FoundList);

 l_Rels:= makeSabCopy(l_Sab);
 l_Value:= 0;
 l_Rels.SubSelect(fRelated_fld, l_Value, Great);

 l_rels.ValuesOfKey(fRelated_fld);
 l_Sab.ValuesOfKey(fId_Fld);
 l_Sab.OrSab(l_Rels);


 l_Sab.TransferToPhoto(rnRealID_fld, LinkServer(CurrentFamily).Attribute[atRenum]);
 l_Sab.ValuesOfKey(rnImportID_fld);
 if l_Sab.Count > 0 then
 begin
  l_Stream:= Tl3FileStream.Create(ConcatDirName(f_TaskParams.ExportFolder, 'tokill.txt'), l3_fmWrite);
  try
   lStub := L2RecAccessProc(@lp_SaveID);
   try
    l_Sab.IterateRecords(lStub, [rnImportID_fld]);
   finally
    FreeRecAccessProc(lStub);
   end;
  finally
   FreeAndNil(l_Stream);
  end;
 end;

 if aeAnnotations in f_TaskParams.Stages then
 begin
  l_Anno:= f_AnnoQuery.FoundList;
  l_Anno.ValuesOfKey(fID_Fld);
  l_Anno.TransferToPhoto(rnRealID_fld, LinkServer(CurrentFamily).Attribute[atRenum]);
  l_Anno.ValuesOfKey(rnImportID_fld);
  if l_Anno.Count > 0 then
  begin
   l_Stream:= Tl3FileStream.Create(ConcatDirName(f_TaskParams.ExportFolder, 'annotokill.txt'), l3_fmWrite);
   try
    lStub := L2RecAccessProc(@lp_SaveID);
    try
     l_Anno.IterateRecords(lStub, [rnImportID_fld]);
    finally
     FreeRecAccessProc(lStub);
    end;
   finally
    FreeAndNil(l_Stream);
   end;
  end;
 end;
end;

procedure TalcuAutoExporter.CalculateAnnotations;
var
 l_Bases: TdtQuery;
 l_Pipe: TExportPipe;
 l_Diapason: TDiapasonRec;
 l_List: Tl3LongintList;
 l_Dict: TdaDictionaryType;
begin
 l3System.Msg2Log('Поиск аннотаций...');
 FreeAndNil(f_AnnoQuery);
 f_Anno:= 0;

  // Нужно оставить только нужные аннотации - от выбранных Групп доументов
  l_Bases:= nil;
  try
   if f_TaskParams.DocumentsSource = ae_dsAccGroups then
   begin
    l_List := Tl3LongintList.Create;
    try
     if f_TaskParams.AnnoUseAccGroups then
     begin
      { TODO : тут, тоже нужно использовать поиск }
      f_TaskParams.AccGroupsIDList.ToList(l_List);
      l_Dict := da_dlAccGroups;
     end
     else
     begin
  {$If not defined(LUK) AND not defined(SGC)}
      f_TaskParams.BasesIDList.ToList(l_List);
  {$IfEnd not defined(LUK) AND not defined(SGC)}
      l_Dict := da_dlBases;
     end;
     l_Bases := TdtDictQuery.Create(l_Dict, l_List, False, True {WithSubTree});
    finally
     FreeAndNil(l_List);
    end;
   end
   else
    l_Bases:= GetDocQuery;

   if l_Bases <> nil then
   begin
    f_AnnoQuery:= SQLogByActionsQuery(
      StDateToDemon(DateTimeToStDate(f_TaskParams.CompileDate)),
      StDateToDemon(DateTimeToStDate(f_TaskParams.Today)),
      [acAnnoDate, acAnnoWork, acAnnoWasImported],
      0,   {Любая группа пользователей}
      True {Ищем по группам}
      );
    SQAnd(f_AnnoQuery, l_Bases);

    f_Anno:= f_AnnoQuery.FoundList.Count;
   end;
  finally
   l3Free(l_Bases);
  end;
end;

procedure TalcuAutoExporter.CalculateChangedDocuments;
var
 l_Q: TdtQuery;
 l_Start, l_Finish: TstDate;
 l_List: Tl3LongIntList;
begin
 l3System.Msg2Log('Поиск изменившихся документов...');
 l3Free(f_ResQuery);
 f_ResQuery := TdtAndQuery.Create;
 // Нужно получить список новых, импортированных и измененных подключенных документов, за диапазон дат
 {$IF not (Defined(LUK) or Defined(SGC))}
 l_Start:= StDateToDemon(DateTimeToStDate(f_TaskParams.CompileDate));
 l_Finish:= StDateToDemon(DateTimeToStDate(f_TaskParams.Today));
 {$ELSE}
 l_Start:= 0;
 l_Finish:= 0;
 {$IFEND}
 l_Q:= TdtSimpleLogQuery.Create(l_Start, l_Finish, 0, False, acfOrdinal);
 TdtAndQuery(f_ResQuery).AddQueryF(l_Q); // Все изменившиеся

 l_Q:= SQDocOnDoneState(cDone);
 TdtAndQuery(f_ResQuery).AddQueryF(l_Q); // Только подключенные
 // фильтруем по группам доступа
 if f_TaskParams.DocumentsSource = ae_dsAccGroups then
 begin
  l_List := Tl3LongIntList.Create;
  try
   f_TaskParams.AccGroupsIDList.ToList(l_List);
   l_Q := TdtDictQuery.Create({$IFDEF AEByBelongs}da_dlBases{$ELSE}da_dlAccGroups{$ENDIF}, l_List);
  finally
   FreeAndNil(l_List);
  end;
 end
 else
  l_Q:= GetDocQuery;
 TdtANDQuery(f_ResQuery).addQueryF(l_Q);
 // вычитаем подключенные на этой неделе
 l_Q := TdtLogByActionQuery.Create(acIncluded,
          StDateToDemon(DateTimeToStDate(f_TaskParams.VersionDate)),  // FromDate
          StDateToDemon(DateTimeToStDate(f_TaskParams.VersionDate))); // ToDate
 SQNot(l_Q);
 TdtAndQuery(f_ResQuery).AddQueryF(l_Q);

 ExpandEditionsIfNeeded(f_ResQuery);

 f_ChangedDocs:= f_ResQuery.FoundList.Count;
end;

procedure TalcuAutoExporter.CalculateIncludedDocuments;
var
 l_Q: TdtQuery;
 l_List: Tl3LongintList;
begin
 l3System.Msg2Log('Поиск новых документов...');
 l3Free(f_NewDocsQuery);
 f_NewDocsQuery := TdtAndQuery.Create;
 l_Q := TdtLogByActionQuery.Create(
        acIncluded,
        StDateToDemon(DateTimeToStDate(f_TaskParams.VersionDate)),  // FromDate
        StDateToDemon(DateTimeToStDate(f_TaskParams.VersionDate)) // ToDate
        );
 TdtAndQuery(f_NewDocsQuery).AddQueryF(l_Q);
 if f_TaskParams.DocumentsSource = ae_dsAccGroups then
 begin
  l_List := Tl3LongintList.Create;
  try
   f_TaskParams.AccGroupsIDList.ToList(l_List);
   l_Q := TdtDictQuery.Create({$IFDEF AEByBelongs}da_dlBases{$ELSE}da_dlAccGroups{$ENDIF}, l_List);
  finally
   FreeAndNil(l_List);
  end;
 end
 else
  l_Q:= GetDocQuery;
 TdtAndQuery(f_NewDocsQuery).AddQueryF(l_Q);

 ExpandEditionsIfNeeded(f_NewDocsQuery);

 f_NewDocs:= f_NewDocsQuery.FoundList.Count;
end;

procedure TalcuAutoExporter.CalculateInfoDocuments;
var
{$IF Defined(LUK) or Defined(SGC)}
 l_Q: TdtQuery;
{$IFEND}
 l_InfoList: Tl3LongintList;
begin
 l3System.Msg2Log('Поиск документов полных групп доступа...');
 l_InfoList := Tl3LongintList.Create;
 try
  f_TaskParams.InfoIDList.ToList(l_InfoList);
  //Ищем все документы из групп (AccGroups) заказанных пользователем
  l3Free(f_AccGr);
  {$IF not Defined(LUK) and not Defined(SGC)}
  f_AccGr := TdtDictQuery.Create({$IFDEF AEByBelongs}da_dlBases{$ELSE}da_dlAccGroups{$ENDIF}, l_InfoList);
  {$ELSE}
  f_AccGr := TdtAndQuery.Create;
  l_Q := TdtLogByActionQuery.Create(
         acIncluded,
         StDateToDemon(MinDate), // FromDate
         StDateToDemon(MaxDate)  // ToDate
         );
  TdtAndQuery(f_AccGr).AddQueryF(l_Q);
  l_Q:= TdtDictQuery.Create({$IFDEF AEByBelongs}da_dlBases{$ELSE}da_dlAccGroups{$ENDIF}, l_InfoList);
  TdtAndQuery(f_AccGr).AddQueryF(l_Q);
  {$IFEND}
  f_Info:= f_AccGr.FoundList.Count;
 finally
  FreeAndNil(l_InfoList);
 end;
end;

procedure TalcuAutoExporter.CalculateNotIncludedDocuments;
var
 l_Q: TdtQuery;
 l_Start, l_Finish: TstDate;
 l_List: Tl3LongintList;
begin
 l3System.Msg2Log('Поиск неподключенных документов...');
 l3Free(f_NotIncDocsQuery);
 f_NotIncDocsQuery := TdtAndQuery.Create;

 // Нужно получить список новых, импортированных и измененных подключенных документов, за диапазон дат
 l_Start:= StDateToDemon(DateTimeToStDate(f_TaskParams.CompileDate));
 l_Finish:= StDateToDemon(DateTimeToStDate(f_TaskParams.Today));
 l_Q:= TdtSimpleLogQuery.Create(l_Start, l_Finish, 0, False, acfOrdinal);
 TdtAndQuery(f_NotIncDocsQuery).AddQueryF(l_Q); // Все изменившиеся

 l_Q:= SQDocOnDoneState(cDone);
 SQAndNotF(f_NotIncDocsQuery, l_Q);

 if f_TaskParams.DocumentsSource = ae_dsAccGroups then
 begin
  l_List := Tl3LongintList.Create;
  try
   f_TaskParams.AccGroupsIDList.ToList(l_List);
   l_Q := TdtDictQuery.Create({$IFDEF AEByBelongs}da_dlBases{$ELSE}da_dlAccGroups{$ENDIF}, l_List);
  finally
   FreeAndNil(l_List);
  end;
 end
 else
  l_Q:= GetDocQuery;
 TdtAndQuery(f_NotIncDocsQuery).AddQueryF(l_Q);

 f_NotIncDocs:= f_NotIncDocsQuery.FoundList.Count;
end;

procedure TalcuAutoExporter.CalculateTotalCount;
begin
 f_Anno:= 0;
 f_ChangedDocs:= 0;
 f_Info:= 0;
 f_NewDocs:= 0;
 if aeAnnotations in f_TaskParams.Stages then
  CalculateAnnotations;
 if aeIncluded in f_TaskParams.Stages then
  CalculateIncludedDocuments;
 if aeChanged in f_TaskParams.Stages then
  CalculateChangedDocuments;
 if aeInfo in f_TaskParams.Stages then
  CalculateInfoDocuments;
 if aeNotIncluded in f_TaskParams.Stages then
  CalculateNotIncludedDocuments;
 if Assigned(f_OnTotalCount) then
  f_OnTotalCount(f_Anno + f_ChangedDocs + f_Info + f_NewDocs);
 // Теперь нужно вычислить справки и добавить в список
 if f_TaskParams.NeedTopicList then
  BuildAndSaveList;
end;

procedure TalcuAutoExporter.Cleanup;
begin
 FreeAndNil(f_TaskParams);
 FreeAndNil(f_TaskResult);
 FreeAndNil(f_Pipe);
 FreeAndNil(f_AnnoQuery);
 FreeAndNil(f_ResQuery);
 FreeAndNil(f_AccGr);
 FreeAndNil(f_NewDocsQuery);
 FreeAndNil(f_NotIncDocsQuery);
 inherited;
end;

procedure TalcuAutoExporter.Execute(aProgressor: TddProgressObject);
var
 l_Report, l_Folder: String;
 l_Start: TDateTime;
begin
 f_Pipe.OnCalculationDone:= f_OnCalculationDone;
 l3System.Msg2Log('--= %s =--', [f_TaskParams.Description]);
 l_Start:= Now;
 f_Pipe.Progressor:= aProgressor;

 l_Folder:= f_TaskParams.ExportFolder;
 if l_Folder <> '' then
 begin
  if not DirectoryExists(l_Folder) then
  begin
   if not ForceDirectories(l_Folder) then
   begin
    l3System.Msg2Log('ОШИБКА: Не удалось создать папку экспорта %s!', [l_Folder]);
    f_TaskResult.ReportMessage := 'Не удалось создать папку экспорта (ОШИБКА)';
    f_TaskResult.IsSuccess := False;
    exit
   end
  end
  else
   PureDir(l_Folder);

  if (f_TaskParams.DocumentsSource = ae_dsQuery) and
     not FileExists(f_TaskParams.DocQueryFileName) then
  begin
   l3System.Msg2Log('ОШИБКА: Файл запроса %s не найден! Проверьте конфигурацию экспорта!', [f_TaskParams.DocQueryFileName]);
   f_TaskResult.ReportMessage := 'Файл запроса не найден (ОШИБКА)';
   f_TaskResult.IsSuccess := False;
   Exit;
  end;
  
  f_Pipe.ExportDirectory:= l_Folder;
  CheckDates;
  f_Pipe.ExportDate := f_TaskParams.Today;
//  MakeDates(aCompileDate, aVersionDate, aToday);
  CalculateTotalCount;

  if aeAnnotations in f_TaskParams.Stages then
   ExportAnnotations;
  if aeIncluded in f_TaskParams.Stages then
   ExportIncludedDocuments;
  if aeChanged in f_TaskParams.Stages then
   ExportChangedDocuments;
  if aeInfo in f_TaskParams.Stages then
   ExportInfoDocuments;
  if aeNotIncluded in f_TaskParams.Stages then
   ExportNotIncludedDocuments;
  if f_Aborted then
   Exit;
  WriteDoneFile;
  ExecuteCommandFile;
  f_TaskResult.IsSuccess := True;
 end; // l_Folder <> ''
 {$IF not Defined(LUK) and not Defined(SGC)}
 PrepareReport(l_Start);
 {$IFEND}
 l3System.Msg2Log('--= %s завершен =--', [f_TaskParams.Description]);
end;

procedure TalcuAutoExporter.ExecuteCommandFile;
var
 l_FileName, l_WorkFolder, l_Params: String;
begin
 if not f_Aborted and GetCommandFileName(l_FileName, l_WorkFolder, l_Params) then
  FileExecuteWait(l_FileName, l_params, l_WorkFolder, esNormal)
//  f_CommandFileResult:= FileExecuteWait(l_FileName, l_params, l_WorkFolder, esNormal)
// else
//  f_CommandFileResult:= 0;
end;

procedure TalcuAutoExporter.ExportAnnotations;
{$If not defined(LUK) AND not defined(SGC)}
var
 l_Pipe: TExportPipe;
 l_Sab: ISab;
{$IfEnd not defined(LUK) AND not defined(SGC)}
begin
 if f_Aborted then
  Exit;
{$If not defined(LUK) AND not defined(SGC)}
 l3System.Msg2Log('-= Экспорт аннотаций =-');
  if f_Anno > 0 then
  begin
   l_Sab := f_AnnoQuery.GetDocIdList;
   try
    f_Pipe.ExportDocument:= False;
    f_pipe.ExportReferences:= False;
    f_Pipe.ExportAnnotation:= True;
    f_Pipe.ExportKW:= False;
    f_Pipe.ExportEmpty:= False;
    f_Pipe.DocSab:= l_Sab;
    f_Pipe.FileMask[edpAnnotation] := l3CStr(f_TaskParams.AnnoTemplate);//'monit.nsr';
    f_Pipe.AllPartsDivideBy([]);
    f_Pipe.Execute;
   finally
    l_Sab := nil;
   end;
  end; // f_Anno > 0
 l3System.Msg2Log('-= Экспорт аннотаций завершен =-');
{$Else not defined(LUK) AND not defined(SGC)}
 Assert(False);
{$IfEnd not defined(LUK) AND not defined(SGC)}
end;

procedure TalcuAutoExporter.ExportChangedDocuments;
{$If not defined(LUK) AND not defined(SGC)}
var
 l_Sab: ISab;
{$IfEnd not defined(LUK) AND not defined(SGC)}
begin
 if f_Aborted then
  Exit;
{$If not defined(LUK) AND not defined(SGC)}
 l3System.Msg2Log('-= Экспорт изменившихся документов =-');
 if f_ChangedDocs > 0 then
 try
  l_Sab := f_ResQuery.GetDocIdList;
  with f_Pipe do
  begin
   ExportDocument:= True;
   ExportReferences:= True;
   ExportAnnotation:= False;
   ExportKW:= False;
   ExportEmpty:= False;
   DocSab := l_Sab;
   FileMask[edpDocument]   := l3CStr(f_TaskParams.ChangedDocTemplate); //'%main%~%number%.nsr';
   FileMask[edpReference]  := l3CStr(f_TaskParams.ChangedRelTempate);//'rel%main%2.nsr';
   FileMask[edpAnnotation] := nil;
   OutputFileSize        := f_TaskParams.PartSize*1024;
   AllPartsDivideBy([edbAccGroup]);
   Execute;
  end; // with
 finally
  l_Sab := nil;
 end;
 l3System.Msg2Log('-= Экспорт изменившихся документов завершен =-');
{$Else not defined(LUK) AND not defined(SGC)}
 Assert(False);
{$IfEnd not defined(LUK) AND not defined(SGC)}
end;

procedure TalcuAutoExporter.ExportIncludedDocuments;
{$If not defined(LUK) AND not defined(SGC)}
var
 l_Sab: ISab;
{$IfEnd not defined(LUK) AND not defined(SGC)}
begin
 if f_Aborted then
  Exit;
{$If not defined(LUK) AND not defined(SGC)}
 l3System.Msg2Log('-= Экспорт новых документов =-');
 if f_NewDocs > 0 then
 begin
  l_Sab := f_NewDocsQuery.GetDocIdList; // получаем список ID документов
  try
   with f_Pipe do
   begin
    ExportDocument:= True;
    ExportAnnotation:= False;
    ExportReferences:= True;
    ExportEditions:= f_TaskParams.WithEditions;
    ExportKW:= False;
    ExportEmpty:= False;
    DocSab:= l_Sab;
    FileMask[edpDocument]  := l3CStr(f_TaskParams.IncludedDocTemplate);//'new%main%.nsr';
    FileMask[edpReference] := l3CStr(f_TaskParams.IncludedRelTemplate);//'rel%main%1.nsr';
    FileMask[edpAnnotation] := nil;
    OutputFileSize        := 0;
    AllPartsDivideBy([edbAccGroup]);
    Execute;
   end; // with
  finally
   l_Sab := nil;
  end;
 end;
 l3System.Msg2Log('-= Экспорт новых документов завершен =-');
{$Else not defined(LUK) AND not defined(SGC)}
 Assert(False);
{$IfEnd not defined(LUK) AND not defined(SGC)}
end;

procedure TalcuAutoExporter.ExportInfoDocuments;
var
 l_Sab: ISab;
begin
 if f_Aborted then
  Exit;
 l3System.Msg2Log('-= Экспорт полных групп доступа =-');
 if f_Info > 0 then
 begin
  l_Sab := f_AccGr.GetDocIdList;
  try
   with f_Pipe do
   begin
    ExportDocument:= True;
    ExportReferences:= True;
    ExportAnnotation:= False;
    ExportKW:= False;
    ExportEmpty:= False;
    DocSab := l_Sab;
    UpdateFiles:= False;
    FileMask[edpDocument] := l3CStr(f_TaskParams.InfoDocTemplate);//'%main%%number%.nsr';
    FileMask[edpReference]:= l3CStr(f_TaskParams.InfoRelTemplate);//'rel_%main%.nsr';
    OutputFileSize        := f_TaskParams.PartSize*1024;
    AllPartsDivideBy([edbAccGroup]);
    Execute;
   end; // with
  finally
   l_Sab := nil;
  end;
 end;
 l3System.Msg2Log('-= Экспорт полных групп доступа завершен =-');
end;

procedure TalcuAutoExporter.ExportNotIncludedDocuments;
{$If not defined(LUK) AND not defined(SGC)}
var
 l_Sab: ISab;
{$IfEnd not defined(LUK) AND not defined(SGC)}
begin
 if f_Aborted then
  Exit;
{$If not defined(LUK) AND not defined(SGC)}
 l3System.Msg2Log('-= Экспорт неподключенных документов =-');
 if f_NotIncDocs > 0 then
 begin
  l_Sab := f_NotIncDocsQuery.GetDocIdList; // получаем список ID документов
  try
   with f_Pipe do
   begin
    ExportDocument:= True;
    ExportAnnotation:= False;
    ExportReferences:= True;
    ExportEditions:= False;
    ExportKW:= False;
    ExportEmpty:= False;
    DocSab := l_Sab;
    FileMask[edpDocument] := l3CStr('raw_'+f_TaskParams.IncludedDocTemplate);//'new%main%.nsr';
    FileMask[edpReference]:= l3CStr('raw_'+f_TaskParams.IncludedRelTemplate);//'rel%main%1.nsr';
    FileMask[edpAnnotation] := nil;
    OutputFileSize        := 0;
    AllPartsDivideBy([edbAccGroup]);
    Execute;
   end; // with
  finally
   l_Sab := nil;
  end;
 end;
 l3System.Msg2Log('-= Экспорт неподключенных документов завершен =-');
{$Else not defined(LUK) AND not defined(SGC)}
 Assert(False);
{$IfEnd not defined(LUK) AND not defined(SGC)}
end;
(*
function TalcuAutoExporter.GetAccGroupsList: Tl3LongintList;
begin
 {$IFDEF AEbyBelongs}
 Result := Tl3LongintList(ddAppConfiguration.AsObject['aiChangedBases']);
 {$ELSE}
 Result := Tl3LongintList(ddAppConfiguration.AsObject['aiAccGroups']);
 {$ENDIF}
end;

function TalcuAutoExporter.GetAnnoTemplate: String;
begin
 Result := ddAppConfiguration.AsString['aiAnnoTemplate'];
end;

function TalcuAutoExporter.GetBasesList: Tl3LongintList;
begin
 Result := Tl3LongintList(ddAppConfiguration.AsObject['aiBases']);
end;

function TalcuAutoExporter.GetChangedDocTemplate: string;
begin
 Result := ddAppConfiguration.AsString['aiChangedDocTemplate'];
end;

function TalcuAutoExporter.GetChangedRelTempate: string;
begin
 Result := ddAppConfiguration.AsString['aiChangedRelTemplate'];
end;

function TalcuAutoExporter.GetCommandFileName(var aFileName, aWorkFolder, aParams: String): Boolean;
begin
 aFileName:= ddAppConfiguration.AsString['aiExecute'];
 aWorkFolder:= ExtractFilePath(aFileName);
 aParams:= ddAppConfiguration.AsString['aiParams'];
 Result := FileExists(aFileName);
end;
*)
function TalcuAutoExporter.GetCommandFileName(var aFileName, aWorkFolder, aParams: String): Boolean;
begin
 aFileName:= f_TaskParams.ExecName;
 aWorkFolder:= ExtractFilePath(aFileName);
 aParams:= f_TaskParams.ExecParams;
 Result := FileExists(aFileName);
end;

function TalcuAutoExporter.GetDocQuery: TdtQuery;
begin
 if FileExists(f_TaskParams.DocQueryFileName) then
  with TSavedQuery.CreateFromFile(f_TaskParams.DocQueryFileName) do
  try
   Result := MakeQuery;
  finally
   Free;
  end
 else
  Result := nil;
end;

procedure TalcuAutoExporter.PrepareReport(aStart: TDateTime);
var
 l_Report: TStrings;
 l_Finish: TDateTime;
begin
 if f_Aborted then
  Exit;
 l_Finish:= Now;
 l_Report:= TStringList.Create;
 try
  with l_Report do
  begin
   Add(f_TaskParams.Description);
   Add(DupeString('=', Length(f_TaskParams.Description)));
   Add('');
   Add('Дата версии       : '+ DateToStr(f_TaskParams.VersionDate));
   Add('Дата компиляции   : ' + DateToStr(f_TaskParams.CompileDate));
   Add('Сегодня           : ' + DateToStr(f_TaskParams.Today));
   Add('');
   Add('Экспорт начался   : ' + DateTimeToStr(aStart));
   Add('Экспорт закончился: ' + DateTimeToStr(l_Finish));
   Add('Продолжительность : ' + CalcElapsedTime(aStart, l_Finish));
   Add('');
   Add('Экспортировано:');
   if aeIncluded in f_TaskParams.Stages then
    Add('  - новых документов                  : '+IntToStr(f_NewDocs));
   if aeChanged in f_TaskParams.Stages then
    Add('  - измененных документов (+ редакции): '+IntToStr(f_ChangedDocs));
   if aeNotIncluded in f_TaskParams.Stages then
    Add('  - неподключённых документов         : '+IntToStr(f_NotIncDocs));
   if aeAnnotations in f_TaskParams.Stages then
    Add('  - аннотаций                         : '+IntToStr(f_Anno));
   if aeInfo in f_TaskParams.Stages then
    Add('  - документов полных групп доступа   : '+IntToStr(f_Info));
   Add('');
  end;
  if (aeIncluded in f_TaskParams.Stages) or (aeChanged in f_TaskParams.Stages) then
  begin
   if f_TaskParams.DocumentsSource = ae_dsAccGroups then
    AddAccGroups(l_Report)
   else
    AddQuery(l_Report);
  end;
  if aeInfo in f_TaskParams.Stages then
   AddFullGroups(l_Report);
  if aeAnnotations in f_TaskParams.Stages then
   AddBases(l_Report);
  f_TaskResult.ReportMessage := l_Report.Text;
 finally
  l3Free(l_Report);
 end;
end;

procedure TalcuAutoExporter.WriteDoneFile;
begin
  if f_Aborted then
   Exit;
 {$IFNDEF AEByBelongs}
  if f_TaskParams.DoneFileName <> '' then
  begin
   ForceDirectories(f_TaskParams.ExportFolder);
   with Tl3FileStream.Create(ConcatDirname(f_TaskParams.ExportFolder, ExtractFileName(f_TaskParams.DoneFileName)), l3_fmWrite) do
   try
   finally
    Free;
   end;
  end; // l_Stream
 {$ENDIF AEByBelongs}
end;

procedure TalcuAutoExporter.AbortProcess;
begin
  f_Aborted := True;
  if Assigned(f_Pipe) then
    f_Pipe.AbortExport;
end;

procedure TalcuAutoExporter.CheckDates;
begin
 Assert(f_TaskParams.Today <> 0);
 Assert(f_TaskParams.VersionDate <> 0);
 Assert(f_TaskParams.CompileDate <> 0);
 l3System.Msg2Log('Подключенные в версию от %s', [DateToStr(f_TaskParams.VersionDate)]);
 l3System.Msg2Log('Измененные и аннотации с %s по %s', [DateToStr(f_TaskParams.CompileDate), DateToStr(f_TaskParams.Today)]);
end;

procedure TalcuAutoExporter.ExpandEditionsIfNeeded(var theQuery: TdtQuery);
var
 l_DocCount: Integer;
 l_DocsWithRelCount: Integer;
 l_Q: TdtQuery;
begin
 if f_TaskParams.ExpandEditions then
 begin
  l_DocCount := theQuery.FoundList.Count;
  l_Q := theQuery;
  theQuery := TdtExpandEditionsQuery.Create;
  TdtExpandEditionsQuery(theQuery).SubQuery := l_Q;
  FreeAndNil(l_Q);
  l_DocsWithRelCount := theQuery.FoundList.Count;
  if l_DocCount <> l_DocsWithRelCount then
   l3System.Msg2Log('Документов: %d    Редакций: %d', [l_DocCount, l_DocsWithRelCount - l_DocCount]);
 end;
end;

end.

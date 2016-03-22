unit alcuAutoClassifier;
{ Выполняет автоклассификацию документов на основе механизма от Бежана }
{ $Id: alcuAutoClassifier.pas,v 1.27 2015/12/21 07:46:06 lukyanets Exp $ }

// $Log: alcuAutoClassifier.pas,v $
// Revision 1.27  2015/12/21 07:46:06  lukyanets
// Несовпадение параметров
//
// Revision 1.26  2015/11/26 08:45:25  lukyanets
// КОнстанты переехали
//
// Revision 1.25  2015/10/14 10:21:19  fireton
// - cleanup
//
// Revision 1.24  2015/10/13 13:00:09  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.23  2015/04/30 11:14:37  lukyanets
// Заготовки Большого Брата
//
// Revision 1.22  2015/04/09 10:12:17  fireton
// - добавляем ААК-доки в автоклассификацию
//
// Revision 1.21  2015/04/07 07:35:52  lukyanets
// Изолируем HT
//
// Revision 1.20  2014/12/18 12:23:15  fireton
// - добавляем в итоговое письмо количество пропущенных документов
//
// Revision 1.19  2014/09/10 06:18:38  lukyanets
// Более адекватное название метода
//
// Revision 1.18  2014/09/02 10:29:03  lukyanets
// Учим экспорт в разные регионы работать одновременно
//
// Revision 1.17  2014/08/26 11:25:35  lukyanets
// Учимся прерывать
//
// Revision 1.16  2014/08/26 10:22:15  lukyanets
// Cleanup
//
// Revision 1.15  2014/08/22 12:54:24  lukyanets
// {Requestlink:563199760}. Отцепляем экспорт прайма
//
// Revision 1.14  2014/08/20 13:17:55  lukyanets
// {Requestlink:558466572}. Отцепили alcuAutoClass
//
// Revision 1.13  2014/08/20 11:19:55  lukyanets
// {Requestlink:558466572}. Отучили alcuAutoClass от ddAppConfig
//
// Revision 1.12  2014/08/20 10:34:39  lukyanets
// {Requestlink:558466572}. Спрямляем наследование alcuAutoClass
//
// Revision 1.11  2014/08/19 12:20:12  lukyanets
// Очеловеченное название
//
// Revision 1.10  2014/08/06 07:55:22  lukyanets
// {Requestlink:556143119}. Готовим TaskResult
//
// Revision 1.9  2014/07/31 10:16:12  lukyanets
// Регестрируем более правильный тип таска
//
// Revision 1.8  2014/07/21 09:26:37  lulin
// - спрямляем модель.
//
// Revision 1.7  2014/07/16 15:57:07  lulin
// - чистим код и упрощаем наследование.
//
// Revision 1.6  2014/07/07 12:10:47  lulin
// - движемся к константности TaskType.
//
// Revision 1.5  2014/06/06 11:20:03  lulin
// - чистим код.
// - исправляем ошибки.
//
// Revision 1.4  2014/05/13 17:46:56  lulin
// {RequestLink:517789752}.
//
// Revision 1.47  2014/04/17 13:07:50  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.46  2014/04/08 04:58:18  fireton
// - не собиралось
//
// Revision 1.45  2014/02/14 15:33:23  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.44  2014/02/12 12:39:12  lulin
// - рефакторим списки заданий.
//
// Revision 1.43  2013/10/21 17:30:51  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.42  2013/10/21 15:42:19  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.41  2013/10/21 10:30:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.40  2013/10/18 16:01:27  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.39  2013/03/19 06:14:02  narry
// Автоклассификация - закрытие этапа (436241318)
//
// Revision 1.38  2013/02/07 13:21:48  narry
// Автоклассификация не отрабатывает, если в выборке нет редакций к документам (427757508)
//
// Revision 1.37  2013/02/06 10:09:02  narry
// Сохранение лога
//
// Revision 1.36  2013/02/05 13:38:05  narry
// Автоклассификация не отрабатывает, если в выборке нет редакций к документам (427757508)
//
// Revision 1.35  2012/10/02 07:59:56  narry
// Обновление
//
// Revision 1.34  2012/09/07 13:33:24  narry
// Не запускаем АК без документов
//
// Revision 1.33  2012/09/07 12:57:47  narry
// Не запускаем АК без документов
//
// Revision 1.32  2012/09/03 09:10:04  narry
// Борьба с подвисанием АК при отсутствии документов
//
// Revision 1.31  2012/07/10 11:02:17  narry
// Этап закрывается от имени пользователя, вызвавшего АК
//
// Revision 1.30  2012/06/29 08:16:59  narry
// Если ничего не экспортировалось (нашлись только справки), АК не запускается
//
// Revision 1.29  2012/05/24 04:41:19  narry
// Экспорт док-в без справок
//
// Revision 1.28  2012/04/05 08:07:53  narry
// Проверка настроек АК перед запуском
//
// Revision 1.27  2011/09/08 08:03:05  fireton
// - поменялось название метода (Update -> ProcessUpdate)
//
// Revision 1.26  2011/08/08 12:52:18  narry
// Отвалился фильтр QQQ (278827615)
//
// Revision 1.25  2011/05/16 13:37:00  narry
// Обработка запроса на импорт "подготовленных" постановлений (266409024)
//
// Revision 1.24  2010/09/24 12:41:07  voba
// - k : 235046326
//
// Revision 1.23  2010/05/14 13:18:05  narry
// - K211878137
// - настройка для ААС
//
// Revision 1.22  2010/02/25 06:38:10  narry
// - удаление зависимости проектов от парня
// - выключение обработки очереди заданий на время еженедельного обновления
//
// Revision 1.21  2009/11/10 08:20:06  narry
// - обновление
// - экспорт произвольных аннотаций в Прайм
//
// Revision 1.20  2009/06/24 13:12:59  narry
// - переделки под новый LinkServer
//
// Revision 1.19  2009/05/27 12:29:20  narry
// - Обновление
//
// Revision 1.18  2009/03/17 09:25:46  narry
// - обновление
//
// Revision 1.17  2009/02/16 14:20:25  narry
// - исправление процедуры, закрывающей этапы
//
// Revision 1.16  2009/02/04 14:16:08  narry
// - использование правильного номера поля
// - запись об изменении атрибута
//
// Revision 1.15  2009/01/23 16:19:11  narry
// - дополенение механизма АК простановкой команды DOC
//
// Revision 1.14  2008/06/10 14:15:27  narry
// - запись в ББ информации о проведенной АК
// - исправление ошибки импорта - запись "престижа" в документ, идущий перед пропущенным
//
// Revision 1.13  2008/06/06 06:11:48  narry
// - очистка папки после окончания работы
//
// Revision 1.12  2008/06/04 08:34:10  narry
// - этапы закрывались у всех документов, а не только у обработанных
// - замена Группы документа на псевдогруппу
//
// Revision 1.11  2008/05/23 15:22:03  narry
// - борьба с падением в HyTech
//
// Revision 1.10  2008/03/12 16:47:09  narry
// - заточка для добавления спецтекста
//
// Revision 1.9  2008/03/04 11:32:41  narry
// - обновление
//
// Revision 1.8  2008/02/27 15:55:21  narry
// - возможность выполнить файл после экспорта
// - условия компиляции
// - файл deleted.lst
// - время в смс
// - условия компиляции
// - другое
//
// Revision 1.7  2008/02/19 15:52:19  narry
// - перенос настроек из garant\base.ini в Конфигурацию
//
// Revision 1.6  2008/02/01 13:16:20  narry
// - ошибка преобразования номеров
//
// Revision 1.5  2008/01/31 12:50:52  narry
// - добавление в отчет номеров справок
//
// Revision 1.4  2008/01/30 09:39:32  narry
// - по окончании Автоклассификации уведомление посылается и через Арчи
//
// Revision 1.3  2007/12/06 11:41:12  lulin
// - собрал "парня".
//
// Revision 1.2  2007/12/06 11:29:59  narry
// - поддержка автоклассификации
//

interface

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

Uses
 l3Base, l3LongintList, l3Types,
 evdBufferedFilter,
 dt_Types, ExportPipe,
 classes, k2Interfaces, csProcessTask, ddProgressObj, k2Types, dtIntf, DT_Sab,

 csTaskResult,
 csAutoClassTask,
 alcuAutoClassTaskResult,
 ddProcesstaskPrim
 ;

type
 TalcuAutoClassifier = class(Tl3Base)
 private
  f_Docs: ISab;
  f_Aborted: Boolean;
  f_TaskParams: TcsAutoClassTask;
  f_TaskResult: TalcuAutoClassTaskResult;
  f_ExportPipe: TExportPipe;
  procedure AddDOCAttr(aDocList: Tl3LongintList);
  function AutoClassify: Boolean;
  procedure BackupResult;
  procedure CheckDocList(var aDocList, aMissedDocs: Tl3LongintList);
  procedure CloseStage(aDocList: Tl3LongintList);
  procedure ClearFolder;
  function ExportDocuments(aProgressor: TddProgressObject): Boolean;
  procedure LoadClassifiedDocuments(aDocList: Tl3LongintList; aProgressor:
      TddProgressObject);
  function LoadResults(aProgressor: TddProgressObject): Boolean;
  procedure LoadUnClassifiedDocuments(aDocList: Tl3LongintList; aProgressor:
      TddProgressObject);
  function SearchDocuments: Boolean;
  procedure UpdateDicts;
  procedure WorkupErrors(var aDocList: Tl3LongintList; aErrors: TStrings);
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aParams: TcsAutoClassTask; const aResult: TalcuAutoClassTaskResult);
  procedure AbortProcess;
  procedure Execute(aProgressor: TddProgressObject);
 end;

 TalcuAutoClassFilter = class(TevdTagBufferedFilter)
 private
  f_QString: string;
  procedure AddClass;
  procedure AddGroups;
  procedure AddQ;
  function QString: string;
 protected
        {-}
  procedure CloseStructure(NeedUndo: Boolean); override;
  function NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean; override;
  function NeedStartBuffering(aID : Integer): Boolean; override;
 public
 end;

 TalcuAutoClassTask = class(TcsAutoClassTask)
 private
  f_Classifier: TalcuAutoClassifier;
  function pm_GetTaskResult: TalcuAutoClassTaskResult;
 protected
  function GetTaskResultClass: TcsTaskResultClass; override;
  procedure DoAbort; override;
  procedure DoRun(const aContext: TddRunContext); override;
  {$If defined(AppServerSide)}
  procedure DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
  function AllowSimultaneousRun: Boolean; override;
 public
  class function CanAsyncRun: Boolean; override;
  constructor Create(aUserID: TUserID); override;
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
  property TaskResult: TalcuAutoClassTaskResult read pm_GetTaskResult;
 end;

function LoadResults(const aFolder: string; const aFileMask: string =
    'autoclass.*'): Boolean;

implementation
uses
 SysUtils,
 alcuAutoClassReader,
  {$If defined(AppServerSide)}
 ddAppConfig,
  {$IfEnd defined(AppServerSide)}
 alcuUtils,
 daUtils,
 daInterfaces,
 daDataProvider,
 daSchemeConsts,
 dt_Const, dt_AttrSchema,
 dt_Doc, dt_Stage, dt_User, dt_log, dt_Mail, dt_Link, dt_Query,
 l3Filer, l3Date, l3FileUtils,
 l3ShellUtils,
 ht_Dll,
 alcuMailServer, k2Tags, l3String, k2base,
 DictItem_Const, TextPara_Const, Block_Const, dt_UserConst, dt_LinkServ,
 csTaskTypes, alcuStrings, ddFileIterator, Document_Const, DT_Utils, ddUtils,
 //csMessageManager,
 dt_SrchQueries, ddServerTask, ddPipeOutInterfaces
 ;

function LoadResults(const aFolder: string; const aFileMask: string =
    'autoclass.*'): Boolean;
var
 l_Sab: ISab;
 l_Date: TstDate;
 l_User: TUserID;
 l_Value: TStageType;
 l_ID: TDocID;
 l_Files: TddFileIterator;
 i: Integer;
 l_Filer: Tl3DosFiler;
begin
  with TalcuClassifiedReader.Create(nil) do
  try
   Family:= CurrentFamily;
   l_Files:= TddFileIterator.Make(aFolder, aFileMask);
   try
    Result:= l_Files.FileList.Count > 0;
    for i:= 0 to Pred(l_Files.FileList.Count) do
    begin
     l_Filer:= Tl3DOSFiler.Make(l_Files.FileList[i]);
     try
      l3System.Msg2Log(l_Files.FileList[i]);
      Filer:= l_Filer;
      Execute;
      //l_List.Assign(DocumentList);
      if not DocumentList.Empty then
      begin
       l_Sab:= MakeValueSet(LinkServer(CurrentFamily)[atStages], stDocID_Key, DocumentList);
       l_Sab.TransferToPhoto(stDocID_Key);
       l_Sab.RecordsByKey;
       l_Value:= stClass;
       l_Sab.SubSelect(stType_Key, l_Value);
       l_Date:= CurrentDate; l_User:= usServerService;
       l_Sab.ModifyRecs(stEDate_Key, l_Date);
       l_Sab.Refresh;
       l_Sab.ModifyRecs(stAuthor_Key, l_User);
       l_Sab.ValuesOfKey(stDocID_Key);
       // Добавить записи в журнал
       LinkServer(CurrentFamily).LogBook.PutLogRecToDocs(l_Sab, acClassWork, l_User);
       GlobalDataProvider.Journal.LogAutoClass(CurrentFamily, DocumentList.Count);
      end; // not aDocList.Empty
      l3System.Msg2Log(' Обработано %d документов', [DocumentList.Count]);
     finally
      l3Free(l_Filer);
     end;
    end;// for i
   finally
    l3Free(l_Files);
   end;
  finally
   Free;
  end // with
end;

procedure TalcuAutoClassifier.AddDOCAttr(aDocList: Tl3LongintList);
var
 l_PrefixSab: ISab;
 l_List: Tl3LongintList;
 l_Type: Byte;
begin
 l_PrefixSab:= MakeValueSet(LinkServer(CurrentFamily)[atPrefixes], lnkDocIDFld, aDocList);
 with l_PrefixSab do
 begin
  TransferToPhoto(lnkDocIDFld, MakePhoto(LinkServer(CurrentFamily)[atPrefixes]));
  RecordsByKey;
  ValuesOfKey(lnkDocIDFld);
  l_List:= dtMakeSortedIDListBySab(l_PrefixSab);
  try
   aDocList.Assign(l_List);
  finally
   l3Free(l_List);
  end;
  TransferToPhoto(fId_Fld, MakePhoto(DocumentServer.FileTbl));
  RecordsByKey;
  l_Type:= Ord(utDoc);
  ModifyRecs(fUserType_Fld, l_Type);
 end;
 // Добавить записи в журнал
 l_PrefixSab.ValuesOfKey(fId_Fld);
 LinkServer(CurrentFamily).LogBook.PutLogRecToDocs(l_PrefixSab, acAttrWork, usServerService);
end;

function TalcuAutoClassifier.AutoClassify: Boolean;
var
 l_Result: Cardinal;
 l_Msg: String;
begin
 l3System.Msg2Log('Классификация исходных документов:');
 l3System.Msg2Log('запуск %s в %s', [f_TaskParams.BuilderFileName, ExtractFileDir(f_TaskParams.BuilderFileName)]);
 l_Result:= FileExecuteWait(f_TaskParams.BuilderFileName, '',
                            ExtractFileDir(f_TaskParams.BuilderFileName),
                            esMinimized);
 if l_Result <> 0 then
  l_Msg:= SysUtils.Format('Ошибка %d классификации', [l_Result])
 else
 begin
  l_Msg:= Format('Классификация завершена. Размер файла результата %s', [Bytes2Str(SizeOfFile(f_TaskParams.ResultFileName))]);
 end;
 l3System.Msg2Log(l_Msg);
 Result:= l_Result = 0;
end;

procedure TalcuAutoClassifier.BackupResult;
var
 l_Folder: String;
begin
 if FileExists(f_TaskParams.ResultFileName) then
 begin
  l_Folder:= ExtractFilePath(f_TaskParams.BuilderFileName)+'\BackupResults';
  ForceDirectories(l_Folder);
  CopyFile(f_TaskParams.ResultFileName, MakeUniqueFileName(l_Folder + '\'+ DateToString(Date)));
  CopyFile(ExtractFilePath(f_TaskParams.BuilderFileName)+'\autoclass.log', MakeUniqueFileName(l_Folder + '\'+ DateToString(Date)));
 end; // FileExists(f_TaskParams.ResultFileName)
end;

procedure TalcuAutoClassifier.CheckDocList(var aDocList, aMissedDocs: Tl3LongintList);
var
 l_FoundDocs: Tl3LongintList;
begin
 l_FoundDocs := dtMakeSortedIDListBySab(f_Docs);
 try
  l_FoundDocs.DeleteList(aDocList); // Пропущенные документы
  aMissedDocs.Assign(l_FoundDocs);
  aDocList.DeleteList(aMissedDocs);
 finally
  l3Free(l_FoundDocs);
 end;
end;

procedure TalcuAutoClassifier.CloseStage(aDocList: Tl3LongintList);
var
 l_Sab: ISab;
 l_Date: TstDate;
 l_User: TUserID;
 l_Value: TStageType;
 l_ID: TDocID;
begin
 if not aDocList.Empty then
 begin
  l_Sab:= MakeValueSet(LinkServer(CurrentFamily)[atStages], stDocID_Key, aDocList);
  l_Sab.TransferToPhoto(stDocID_Key);
  l_Sab.RecordsByKey;
  l_Value:= stClass;
  l_Sab.SubSelect(stType_Key, l_Value);
  l_Date:= CurrentDate; l_User:= usServerService;
  l_Sab.ModifyRecs(stEDate_Key, l_Date);
  l_Sab.Refresh;
  l_Sab.ModifyRecs(stAuthor_Key, l_User);
  l_Sab.ValuesOfKey(stDocID_Key);
  // Добавить записи в журнал
  LinkServer(CurrentFamily).LogBook.PutLogRecToDocs(l_Sab, acClassWork, l_User);
  GlobalDataProvider.Journal.LogAutoClass(CurrentFamily, aDocList.Count);
 end; // not aDocList.Empty
end;

procedure TalcuAutoClassifier.ClearFolder;
begin
 PureDir(f_TaskParams.SourceFolder);
 PureDir(ExtractFilePath(f_TaskParams.ResultFileName));
end;

procedure TalcuAutoClassifier.Execute(aProgressor: TddProgressObject);
var
 l_Do: Boolean;
begin
 l3System.Msg2Log('Начало автоклассификации');
 if FileExists(f_TaskParams.BuilderFileName) and (f_TaskParams.SourceFolder <> '') then
 begin
  ClearFolder;
  l_Do:= SearchDocuments;
  try
   if l_Do and not f_Aborted then
   begin
    if ExportDocuments(aProgressor) then
    begin
     if f_Aborted then
      Exit;
     UpdateDicts;
     if f_Aborted then
      Exit;
     if AutoClassify and not f_Aborted then
     begin
      LoadResults(aProgressor);
      BackupResult;
     end
    end // ExportDocuments(aProgressor)
    else
     l3System.Msg2Log('Документов с открытым этапом Классификация не найдено');
   end //l_do
   else
    l3System.Msg2Log('Документов с открытым этапом Классификация не найдено');
  finally
   f_Docs:= nil;
  end;
  ClearFolder;
  l3System.Msg2Log('Автоклассификация завершена');
 end
 else
  l3System.Msg2Log('Не настроен комплекс Автоклассификации');;
end;

function TalcuAutoClassifier.ExportDocuments(aProgressor: TddProgressObject): Boolean;
var
 l_Filter: TalcuAutoClassFilter;
begin
 l_Filter:= TalcuAutoClassFilter.Create(k2_tiGroups);
 try
  f_ExportPipe := TExportPipe.Create;
  try
   with f_ExportPipe do
   begin
    Progressor            := aProgressor;
    Family                := CurrentFamily;
    (*
                     atShortName, atFullName, atPriceLevel, atNotTM, atPriority, atSortDate,
                     atRelated, atVerLink, atUrgency, atComment,
                     atDateNums,
                     atSources, atTypes, atPrefixes, atClasses, atKeyWords, atBases {edBelongs},
                     atWarnings, atPublisheds, atTerritories, atNorms,
                     atAccGroups, atAnnoClasses, atServiceInfo,
                     atCorrects, atAlarms, atActiveIntervals, atStages, atJurLogRecords, atOrdLogRecords,
                     atDoc2DocLink,
                     atHLink, atSub,
                     atRenum,
                     atVersions
    *)
    Attributes            := [atFullName, atSources, atTypes, atBases, atSub, atTerritories, atNorms];
    ExportEmpty           := False;
    ExportDocument        := True;
    ExportEditions        := False;
    ExportReferences      := False; // Все равно не классифицируются
    ExportAnnotation      := False;
    ExportRTFBody         := False;
    ExportKW              := False;
    ExportDocImage        := False;
    MultiUser             := True;
    InternalFormat        := False;
    OutFileType           := outNSRC;
    AllPartsDivideBy([edbSize]);
    FileMask[edpDocument]   := l3CStr('doc.nsr');
    FileMask[edpReference]  := l3CStr('rel.nsr');
    FileMask[edpAnnotation] := nil;
    ObjTopicFileName      := 'obj.nsr';
    KWFileName            := '';
    OutputFileSize        := 10*1024*1024;
    OnlyStructure         := False;
    DocSab                := f_Docs;
    ExportDirectory       := f_TaskParams.SourceFolder;
    AddBend(l_Filter);
    Execute;
    Result                := True;//TotalDone > 0;
   end;
  finally
   FreeAndNil(f_ExportPipe);
  end;
 finally
  l3Free(l_Filter);
 end;
end;

procedure TalcuAutoClassifier.LoadClassifiedDocuments(aDocList: Tl3LongintList;
    aProgressor: TddProgressObject);
var
 l_Filer: Tl3DosFiler;
begin
 if FileExists(f_TaskParams.ResultFileName) then
  with TalcuClassifiedReader.Create(nil) do
  try
   Family:= CurrentFamily;
   l_Filer:= Tl3DOSFiler.Make(f_TaskParams.ResultFileName);
   try
    l_Filer.Indicator.OnProgressProc:= aProgressor.ProcessUpdate;
    l_Filer.Indicator.NeedProgressProc:= True;
    Filer:= l_Filer;
    Execute;
    aDocList.Assign(DocumentList);
    WorkupErrors(aDocList, Errors);
   finally
    l3Free(l_Filer);
   end;
  finally
   Free;
  end
 else
  l3System.Msg2Log('Не найден файл результата классификации');
end;

function TalcuAutoClassifier.LoadResults(aProgressor: TddProgressObject):
    Boolean;
var
 l_DocList: Tl3LongintList;
begin
 Result:= False;
 l_DocList:= Tl3LongintList.Make;
 try
  LoadClassifiedDocuments(l_DocList, aProgressor);
  LoadUnClassifiedDocuments(l_DocList, aProgressor);
  if not l_DocList.Empty then
   CloseStage(l_DocList);
  Result:= not l_DocList.Empty;
 finally
  l3Free(l_DocList);
 end;
end;

procedure TalcuAutoClassifier.LoadUnClassifiedDocuments(aDocList:
    Tl3LongintList; aProgressor: TddProgressObject);
var
 l_Filer: Tl3DosFiler;
begin
 if FileExists(f_TaskParams.LogFileName) then
  with TalcuNotClassifiedReader.Create(nil) do
  try
   l_Filer:= Tl3DOSFiler.Make(f_TaskParams.LogFileName);
   try
    l_Filer.Indicator.OnProgressProc:= aProgressor.ProcessUpdate;
    l_Filer.Indicator.NeedProgressProc:= True;
    Filer:= l_Filer;
    Execute;
    // В списке должны остаться только те документы, которым добавлена команда !DOC
    if not DocumentList.Empty then
    begin
     AddDOCAttr(DocumentList);
     // Список может содержать элементы
     aDocList.JoinWith(DocumentList);
    end; // not DocumentList.Empty
   finally
    l3Free(l_Filer);
   end;
  finally
   Free;
  end
 else
  l3System.Msg2Log('Не найден файл с неклассифицированными документами');
end;

function TalcuAutoClassifier.SearchDocuments: Boolean;
var
 l_QStage, l_QUserType: TdtQuery;
begin
 Result:= False;
 l_QStage:= TdtStageQuery.Create(MinDate, MaxDate, stClass, stfUnfinished);
 try
  l_QUserType:= TdtDocTypeFilterQuery.Create();
  TdtDocTypeFilterQuery(l_QUserType).UserTypeFilter:= [utNone, utDoc, utIzm, utAAK_Doc];
  TdtDocTypeFilterQuery(l_QUserType).DocTypeFilter:= [dtText];
  SQAndF(l_QStage, l_QUserType);
  f_Docs:= l_QStage.GetDocIdList;
 finally
  FreeAndNil(l_QStage);
 end;
 Result:= f_Docs.Count > 0;
end;

procedure TalcuAutoClassifier.UpdateDicts;
begin
 // TODO -cMM: Обновить эталонные файлы для автоклассификации
end;

procedure TalcuAutoClassifier.WorkupErrors(var aDocList: Tl3LongintList; aErrors: TStrings);
var
 l_MissedDocs: String;
 l_Msg: String;
 l_MissedList: Tl3LongintList;
begin
 l_Msg:= Format('Автоклассификация завершена'#13#10'Проставлены классы (документов) - %d', [aDocList.Count]);
 l_MissedList:= Tl3LongintList.make;
 try
  CheckDocList(aDocList, l_MissedList);
  if not l_MissedList.Empty then // Эти документы все равно закрываются
  begin
   CloseStage(l_MissedList);
   ConvertList2Text(l_MissedList, l_MissedDocs, False);
   f_TaskResult.MissedDocsStr := l_MissedDocs;
   l_Msg := l_Msg + Format(#13#10'Просто закрыт этап (документов) - %d', [l_MissedList.Count]);
  end; // not aDocList.Empty
  if aErrors.Count > 0 then
   l_Msg:= l_Msg + #13#10'Не найдены и не проставлены классы:'#13#10 + aErrors.Text;
  f_TaskResult.DocumentIDList.FromList(aDocList);
 finally
  l3Free(l_MissedList);
 end;
 f_TaskResult.ReportMessage := l_Msg;
end;

procedure TalcuAutoClassFilter.AddClass;
begin
 Generator.StartTag(k2_tiClasses);
 try
   Generator.StartChild(k2_typDictItem);
   try
    Generator.AddStringAtom(k2_tiName, 'Общие вопросы хозяйственной и предпринимательской деятельности\Общие вопросы хозяйственной деятельности');
   finally
    Generator.Finish;
   end;
 finally
   Generator.Finish;
 end;
end;

procedure TalcuAutoClassFilter.AddGroups;
begin
 Generator.StartTag(k2_tiGroups);
 try
   Generator.StartChild(k2_typDictItem);
   try
    Generator.AddStringAtom(k2_tiShortName, 'GAR');
   finally
    Generator.Finish;
   end;
 finally
   Generator.Finish;
 end;
end;

procedure TalcuAutoClassFilter.AddQ;
begin
 Generator.StartChild(k2_typTextPara);
 try
  Generator.AddStringAtom(k2_tiText, QString);
 finally
  Generator.Finish;
 end;
end;

procedure TalcuAutoClassFilter.CloseStructure(NeedUndo: Boolean);
var
 l_AddQ: Boolean;
begin
 l_AddQ:=  CurrentType.IsKindOf(k2_typBlock, [k2_typDocument]);
 inherited;
 if l_AddQ then
  AddQ
end;

function TalcuAutoClassFilter.NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
  //virtual;
  {-}
begin
 if aLeaf.IsValid then
  if aTagId = k2_tiPrefix then
  begin
   AddClass;
   Result:= True;
  end
  else
  if aTagId = k2_tiGroups then
  begin
   Result:= False;
   AddGroups;
  end;;
end;

function TalcuAutoClassFilter.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result:= (aID = k2_tiGroups) or (aID = k2_tiPrefix);
end;

function TalcuAutoClassFilter.QString: string;
begin
 if f_QString = '' then
  f_QString:= l3Dup('Q', 70, ' ');
 Result := f_QString;
end;

{
******************************** TddProcessTask ********************************
}
function TalcuAutoClassTask.AllowSimultaneousRun: Boolean;
begin
  Result := False;
end;

class function TalcuAutoClassTask.CanAsyncRun: Boolean;
begin
  Result := True;
end;

constructor TalcuAutoClassTask.Create(aUserID: TUserID);
begin
 inherited;
 //TaskType:= cs_ttAutoClass;
 Description:= 'Автоклассификация документов';
end;

procedure TalcuAutoClassTask.DoAbort;
begin
 inherited DoAbort;
 if f_Classifier <> nil then
  f_Classifier.AbortProcess;
end;

procedure TalcuAutoClassTask.DoRun(const aContext: TddRunContext);
begin
 try
  f_Classifier := TalcuAutoClassifier.Create(Self, TaskResult);
  try
   f_Classifier.Execute(aContext.rProgressor);
  finally
   FreeAndNil(f_Classifier);
  end;
 except
  on E: Exception do
  begin
   l3System.Msg2Log(rsAutoclassifyTaskCreateError);
   Exception2Log(E);
  end;
 end;
end;

  {$If defined(AppServerSide)}
procedure TalcuAutoClassTask.DoRunSuccessfullyFinished(
  const aServices: IcsRunTaskServices);
var
 l_MailType   : TMailType;
 l_MailAttach : TDocumentSabList;
begin
 if IsUserRequireReports(UserID) then
 begin
   if TaskResult.DocumentIDList.Count > 0 then
   begin
    l_MailAttach:= TDocumentSabList.CreateEmpty(CurrentFamily);
    try

     ConvertList2Storage(TaskResult.DocumentIDList, l_MailAttach, False);
     if l_MailAttach.Count > 0 then
     begin
      l_MailType:= mlDocList;
     end //
     else
     begin
      l_MailType:= mlNone;
      FreeAndNil(l_MailAttach);
     end;
     MailServer.SendMail(l_MailType,         // тип сообщения
                         UserID,            // номер адресата
                         Format('Автоклассификация от %s', [DateToStr(SysUtils.Date)]),// Тема сообщения
                         PChar(TaskResult.ReportMessage),    // текст сообщения
                         l_MailAttach);       // выборка номеров
    finally
     l3Free(l_MailAttach);
    end; // try..finally
   end; // f_TopicList.Count > 0
 end; // IsUserRequireReports(f_TaskParams.UserID)

 if (TaskResult.MissedDocsStr <> '') and alcuMail.EnableSend then // Эти документы все равно закрываются
  alcuMail.SendEmail('class@garant.ru', TaskResult.MissedDocsStr, 'АК не обработаны документы', True);
 alcuMail.SendEmail(eMailNotifyList, TaskResult.ReportMessage, 'Результаты автоклассификации');
end;
  {$IfEnd defined(AppServerSide)}

function TalcuAutoClassTask.GetTaskResultClass: TcsTaskResultClass;
begin
  Result := TalcuAutoClassTaskResult;
end;

function TalcuAutoClassTask.pm_GetTaskResult: TalcuAutoClassTaskResult;
begin
  Result := TalcuAutoClassTaskResult(inherited TaskResult);
end;

  {$If defined(AppServerSide)}
procedure TalcuAutoClassTask.SetupServerSideConfigParams;
begin
  inherited;
  BuilderFileName := ddAppConfiguration.AsString['AC_Builder'];
  ResultFileName := ddAppConfiguration.AsString['AC_FileName'];
  SourceFolder := ddAppConfiguration.AsString['AC_Folder'];
  LogFileName := ddAppConfiguration.AsString['AC_LogFileName'];
  eMailNotifyList := ddAppConfiguration.AsString['AC_eMail'];
end;
  {$IfEnd defined(AppServerSide)}

procedure TalcuAutoClassifier.Cleanup;
begin
  FreeAndNil(f_TaskParams);
  FreeAndNil(f_TaskResult);
  inherited Cleanup;
end;

constructor TalcuAutoClassifier.Create(const aParams: TcsAutoClassTask;
  const aResult: TalcuAutoClassTaskResult);
begin
  inherited Create;
  aParams.SetRefTo(f_TaskParams);
  aResult.SetRefTo(f_TaskResult);
end;

procedure TalcuAutoClassifier.AbortProcess;
begin
  f_Aborted := True;
  if Assigned(f_ExportPipe) then
   f_ExportPipe.AbortExport;
end;

initialization
 RegisterTaskClass(cs_ttAutoClass, TalcuAutoClassTask, 'автоклассификация документов');

end.

unit alcuPrime;
{ Обработка экспорта аннотаций для Прайма }

{ $Id: alcuPrime.pas,v 1.12 2015/07/02 11:40:58 lukyanets Exp $ }

// $Log: alcuPrime.pas,v $
// Revision 1.12  2015/07/02 11:40:58  lukyanets
// Описываем словари
//
// Revision 1.11  2015/07/02 07:46:38  lukyanets
// Отправляем письмо
//
// Revision 1.10  2015/07/02 07:34:38  lukyanets
// Описываем словари
//
// Revision 1.9  2014/10/15 10:58:32  lukyanets
// Отучаем ddAppCOnfig от dd
//
// Revision 1.8  2014/08/29 11:03:13  lukyanets
// Неверно абортировали
//
// Revision 1.7  2014/08/26 11:43:32  lukyanets
// Учимся прерывать
//
// Revision 1.6  2014/08/26 07:53:37  lukyanets
// Посылаем письмо с сервера
//
// Revision 1.5  2014/08/22 09:15:17  lukyanets
// {Requestlink:563199760}. Отучили Прайм от ddAppConfig
//
// Revision 1.4  2014/08/22 08:04:21  lukyanets
// {Requestlink:563199760}. Готовимся отучать от ddAppConfig
//
// Revision 1.3  2014/08/21 10:31:59  lukyanets
// Cleanup
//
// Revision 1.2  2014/08/05 06:30:30  lukyanets
// {Requestlink:558466572}. Правильные Define
//
// Revision 1.1  2014/07/28 15:18:16  lukyanets
// {Requestlink:557844282}. Используем правильный ProjectDefine.inc
//
// Revision 1.39  2014/07/14 16:31:53  lulin
// - вычищаем мусор.
//
// Revision 1.38  2014/05/08 11:49:13  fireton
// - избавляемся от диапазонов в экспорте
//
// Revision 1.37  2014/04/17 13:07:50  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.36  2014/02/27 07:50:22  fireton
// - вычищаем Choise
//
// Revision 1.35  2014/02/14 15:33:23  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.34  2013/07/18 09:56:56  fireton
// - немного отладочного кода
//
// Revision 1.33  2013/04/16 13:09:39  narry
// Обновление
//
// Revision 1.32  2013/03/26 11:42:28  narry
// Не выливать Hang-документы для Прайма на сайт  (443842617)
//
// Revision 1.31  2013/02/04 11:07:03  fireton
// - не выливаем справки
//
// Revision 1.30  2012/12/10 07:52:22  narry
// Не экспоритровался Прайм
//
// Revision 1.29  2011/05/03 11:23:22  narry
// Расширение функциональности (265394281)
//
// Revision 1.28  2011/04/28 12:37:24  narry
// Расширение функциональности (265394281)
//
// Revision 1.27  2011/02/25 08:58:48  narry
// - отбивка списка топиков от заголовка
//
// Revision 1.26  2011/02/14 13:49:53  narry
// K223609035. Список экспортированных аннотаций
//
// Revision 1.25  2010/09/24 12:41:08  voba
// - k : 235046326
//
// Revision 1.24  2010/08/18 11:29:07  narry
// - не собиралось в связи с переименованием dt_Srch2
//
// Revision 1.23  2010/07/06 12:27:02  narry
// - К222759027
//
// Revision 1.22  2010/07/06 07:11:01  narry
// - внеочередная сборка для регионов
//
// Revision 1.21  2010/06/16 14:04:41  narry
// - K206078273
//
// Revision 1.20  2010/02/25 06:38:10  narry
// - удаление зависимости проектов от парня
// - выключение обработки очереди заданий на время еженедельного обновления
//
// Revision 1.19  2009/11/10 08:36:26  narry
// - обновление
//
// Revision 1.18  2009/11/10 08:20:06  narry
// - обновление
// - экспорт произвольных аннотаций в Прайм
//
// Revision 1.17  2009/06/16 13:20:53  narry
// - если экспорт Прайма завершился неудачей, экпорт аннотаций для компиляции не выполняется
//
// Revision 1.16  2009/05/27 12:29:20  narry
// - Обновление
//
// Revision 1.15  2009/02/16 14:32:29  narry
// - обновление
//
// Revision 1.14  2009/01/26 08:59:44  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.13  2009/01/23 16:24:59  narry
// - рефакторинг
//
// Revision 1.12.2.1  2009/01/23 14:07:40  fireton
// - перенос Парня на Query
//
// Revision 1.12  2008/11/24 15:07:18  narry
// - присвоение семейства
//
// Revision 1.11  2008/10/13 12:38:41  narry
// - промежуточное обновление
//
// Revision 1.10  2008/07/16 16:13:38  narry
// - последствия рефакторинга
//
// Revision 1.9  2008/06/10 14:15:27  narry
// - запись в ББ информации о проведенной АК
// - исправление ошибки импорта - запись "престижа" в документ, идущий перед пропущенным
//
// Revision 1.8  2008/06/06 15:08:03  narry
// - обновление
//
// Revision 1.7  2008/06/04 08:36:44  narry
// - ошибки обращения к элементам конфигурации
//
// Revision 1.6  2008/05/16 13:30:53  narry
// - обновление
//
// Revision 1.5  2008/05/14 11:23:36  narry
// - уменьшение объема выоводимой в лог инфы для регионов
// - рефакторинг конфигурации
// - переделки Прайма
//
// Revision 1.4  2008/05/07 08:53:55  narry
// - неправильно вычислялся диапазон дат
// - неверно формировалось имя вложения в письмо
//
// Revision 1.3  2008/04/23 10:43:15  narry
// - обновление
//
// Revision 1.2  2008/03/13 14:00:48  narry
// - рефакторинг
// - параметр Группа документа не является обязательным
//
// Revision 1.1  2008/03/04 11:34:04  narry
// - расширение функционала экспорта аннотаций для Прайм
//


interface

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

Uses
 l3Base,
 classes,
 ht_Const,
 ddProgressObj,
 dtIntf,
 dt_Sab,
 DT_types,
 SewerPipe,
 csAnnotationTask,
 alcuAnnotationTaskResult;

type
 TalcuPrime = class(Tl3Base)
 private
  f_TaskParams: TcsAnnotationTask;
  f_TaskResult: TalcuAnnotationTaskResult;
  f_Aborted: Boolean;
  f_PipeToAbort: TSewerPipe;
  function AnalyzeAnnoLog(aLogFileName: string): Boolean;
  function DocListFileName: string;
  function MissedListFileName: string;
  function ExportDocsOnAnno(const aDocs: ISab; aProgressor: TddProgressObject): Boolean;
  function ExportAnnos(const aAnnos: ISab; aProgressor: TddProgressObject; aNamesList,
      aMissedNamesList: TStrings): Boolean;
  function LoadPrevDocs: ISab;
  function MakeAnnoFileName(aFolder: String; aDate: TDateTime): string;
  function MakeAnnotations(aFrom, aTo: TDateTime; out DocSab: ISab; out TodayList, AllDaysList, NamesList: TStrings): ISab;
  procedure SaveCurDocs(aSab: ISab);
  procedure MakeAnnodate(out StartDate, FinishDate: TDateTime);
 protected
  procedure CombineNames(aNamesList, aMissedNamesList: TStrings);
  procedure Cleanup; override;
 public
  constructor Create(const aParams: TcsAnnotationTask;
    const aResult: TalcuAnnotationTaskResult);
  procedure AbortProcess;
  procedure Execute(aProgressor: TddProgressObject);
 end;

(*
type
 TalcuPrimeLite = class(Tl3Base)
 private
  function MakeAnnoFileName(aFolder: String; aDate: TDateTime): string;
  function MakeAnnotations(aFrom, aTo: TDateTime; out DocSab: ISab; out TodayList, AllDaysList, NamesList: TStrings): ISab;
 public
  function Execute(aProgressor: TddProgressObject): Boolean;
  class procedure MakeAnnodate(out StartDate, FinishDate: TDateTime);
 end;
*)
implementation

Uses
 SysUtils, DateUtils, Types,
 daTypes,
 dt_Const, dt_AttrSchema, dt_ImpExpTypes,
 dt_Dict, dt_Doc, dt_Serv, dt_Query, dt_SrchQueries,
 l3Stream, l3FileUtils, l3Types, l3Date,  l3LongintList,
 ddUtils, ddAnnotations,  ddHTMLAnno,
 alcuStrings, alcuUtils,
 ht_dll, Forms, l3String, Math, l3ShellUtils, DT_LinkServ, csTaskTypes,
 StrUtils, dt_Utils, ddDocTypeDetector;

function TalcuPrime.AnalyzeAnnoLog(aLogFileName: string): Boolean;
begin
 Result := True;
 if f_TaskParams.NeedAnalyzeLog and FileExists(aLogFileName) then
  Result := SizeofFile(aLogFileName) = 0;
end;

procedure TalcuPrime.CombineNames(aNamesList, aMissedNamesList: TStrings);
var
 i, j: Integer;
 l_Found: Boolean;
begin
 i:= 0;
 while i <> aMissedNamesList.Count do
 begin
  l_Found:= False;
  for j:= 0 to Pred(aNamesList.Count) do
   if AnsiStartsStr(aMissedNamesList.Names[i], aNamesList[j]) then
   begin
    l_Found:= true;
    aNamesList[j]:= aNamesList[j] + '<<<>>>' + aMissedNamesList.ValueFromIndex[i];
    aMissedNamesList.Delete(i);
    break;
   end;
  if not l_Found then
   Inc(i);
 end;
end;

function TalcuPrime.DocListFileName: string;
begin
 Result := ExtractFilePath(Application.ExeName) + '\DocAnno.lst';
end;

function TalcuPrime.MissedListFileName: string;
begin
 Result := ExtractFilePath(Application.ExeName) + '\NamesAnno.lst';
end;

procedure TalcuPrime.Execute(aProgressor: TddProgressObject);
var
 l_Stream: Tl3FileStream;
 tmpSab, tmpSab2: ISab;
 l_DateStr, l_Msg: String;
 l_StartDate,
 l_FinishDate : TDateTime;
 //l_Params: TExpQueryRec;
 l_TodayList, l_AllDaysList: TStrings;
 l_NamesList, l_MissedNamesList: TStrings;
 i: Integer;
 l_FileName, l_ExportFolder: String;
 l_Attach: TStrings;
 l_Result: Integer;
 l_ExeName: String;
 l_Q: TdtDocListQuery;
begin
 f_TaskResult.IsSuccess := False;
 // Собственно аннотации
 MakeAnnodate(l_StartDate, l_FinishDate);
 l3System.Msg2Log('Экспорт Прайм с %s по %s', [DateToStr(l_StartDate), DateToStr(l_FinishDate)]);
 l_FileName := MakeAnnoFileName(SafeValidFolder(f_TaskParams.TargetFolder), l_FinishDate);
 if l_FileName = '' then
 begin
  f_TaskResult.ReportMessage := 'Не задана группа документов, экспорт невозможен';
  f_TaskResult.ReportSubject := SalcuRequestService_Eksportannotaciy;
  f_TaskResult.NeedReport := f_TaskParams.eMailNotifyList <> '';
  l3System.Msg2Log(f_TaskResult.ReportMessage);
 end
 else
 begin
  l_NamesList := TStringList.Create;
  try
   l_MissedNamesList:= TStringList.Create;
   try
    // Загружаем предыдущие аннотации
    if FileExists(MissedListFileName) then
     l_MissedNamesList.LoadFromFile(MissedListFileName);
    l_TodayList := TStringList.Create;
    try
     l_AllDaysList := TStringList.Create;
     try
      {$IFDEF DEBUG_PRIME}
      (* ОТЛАДОЧНЫЙ КОД *)
      l_Q := TdtDocListQuery.Create;
      try
       l_Q.AddID(949216);
       tmpSab := l_Q.GetDocIdList;
      finally
       FreeAndNil(l_Q);
      end;
      {$ELSE}
      tmpSab:= MakeAnnotations(l_StartDate, l_FinishDate, tmpSab2, l_TodayList, l_AllDaysList, l_NamesList);
      if f_Aborted then
        Exit;
      {$ENDIF}
      CombineNames(l_NamesList, l_MissedNamesList);
      if (tmpSab.Count > 0) and not f_Aborted then
      begin
       with TddAnnotationPipe.Create do
       try
        f_PipeToAbort := Pipe;
        Pipe.Family:= CurrentFamily;
        Pipe.DocSab:= tmpSab;
        Pipe.ExportDocTypes:= [dtAnnotation];
        Pipe.ExportDirectory:= SafeValidFolder(f_TaskParams.TargetFolder);
        //ForceDirectories(Pipe.ExportDirectory);
        FileName := l_FileName;
        Pipe.Progressor := aProgressor;
        Execute;
        if f_Aborted then
          Exit;
        l_ExeName:= f_TaskParams.ExternalProcessor;
        if l_ExeName <> '' then
         l_Result:= FileExecuteWait(l_ExeName,
                                    f_TaskParams.OutFolder,
                                    ExtractFileDir(l_ExeName),  esMinimized)
        else
         l_Result:= 0;
        if l_Result <> 0 then
         l3System.Msg2Log('Ошибка %d выполнения файла %s', [l_Result, l_ExeName]);
        f_TaskResult.IsSuccess := (l_Result = 0) and AnalyzeAnnoLog(l_FileName + '.log') and not f_Aborted;
        if f_TaskResult.IsSuccess then
        begin
         DateTimeToString(l_DateStr, SalcuRequestService_HNn, Now);
         l_Msg := SysUtils.Format(SalcuRequestService_Zdravstvuytedorogiepol_zovateli+
                         SalcuRequestService_Speshuuvedomit_toannotaciikolies,
                         [Pipe.TopicDone, l_DateStr]);
         // Добавляем список аннотаций
         l_Msg:= l_Msg + #13#10'Список аннотаций'#13#10;
         for i:= 0 to Pipe.TopicsList.Hi do
          l_Msg:= l_Msg + IntToStr(Pipe.TopicsList[i]) + #13#10;
         l_Msg:= l_Msg + #13#10;

         if f_TaskParams.PrimeRobotEMail <> '' then
         begin
          f_TaskResult.NeedSendToRobot := True;
          l_Attach:= TStringList.Create;
          try
           if l_ExeName <> '' then
            if l3IsRelativePath(f_TaskParams.OutFolder) then
             l_Attach.Add(ConcatDirName(ConcatDirName(ExtractFileDir(l_ExeName), f_TaskParams.OutFolder), ExtractFileName(l_FileName)))
            else
             l_Attach.Add(ConcatDirName(f_TaskParams.OutFolder, ExtractFileName(l_FileName)))
           else
            l_Attach.Add(ConcatDirName(Pipe.ExportDirectory, ExtractFileName(l_FileName)));
           f_TaskResult.RobotAttach := l_Attach.Text;
           f_TaskResult.RobotMessage := Format('Прайм с %s по %s', [DateToStr(l_StartDate), DateToStr(l_FinishDate)]);
          finally
           l3Free(l_Attach);
          end;
         end; // f_TaskParams.PrimeRobotEMail <> ''
        end
        else
        begin
         l_Attach:= TStringList.Create;
         try
          l_Attach.Add(l_FileName + '.log');

          f_TaskResult.ReportMessage := 'Ошибки оформления подключенных аннотаций во вложении';
          f_TaskResult.ReportSubject := 'Ошибки аннотаций';
          f_TaskResult.NeedReport := f_TaskParams.eMailNotifyList <> '';
          f_TaskResult.ReportAttach := l_Attach.Text;
         finally
          l3Free(l_attach);
         end;
        end; // SizeofFile(aLogFileName) > 0

       finally
        f_PipeToAbort := nil;
        Free;
       end;
      end
      else
      begin
       l_Msg := SalcuRequestService_Spriskorbiemsoobtshayutonebyloek;
       if f_Aborted then
         l_Msg := l_Msg + 'Процесс прерван.';
       Tl3FileStream.Create(l_FileName, l3_fmWrite).Free;
       l3System.Msg2Log(l_Msg);
       f_TaskResult.ReportMessage := l_Msg;
       f_TaskResult.ReportSubject := 'Экспорт завершился почти успешно';
       f_TaskResult.NeedReport := f_TaskParams.eMailNotifyList <> '';
      end;
      if f_TaskParams.ExportDocuments then
      begin
       // Добавить к l_Msg списки документов
       if l_TodayList.Count > 0 then
        l_Msg := l_Msg  + #13#10#13#10'К сожалению, сегодня не закончена обработка следующих документов:'#13#10#13#10 + l_TodayList.Text;
       if l_AlldaysList.Count > 0 then
        l_Msg := l_Msg  + #13#10#13#10'Ожидают завершения обработки следующие документы:'#13#10#13#10 + l_AllDaysList.Text;
      end; // f_TaskParams.ExportDocuments
     finally
      l3Free(l_AllDaysList);
     end;
    finally
     l3Free(l_TodayList);
    end;
    if f_TaskResult.IsSuccess then
    begin
     if f_TaskParams.ExportDocuments then
     begin
      if f_Aborted then
        Exit;
      l3System.Msg2Log('Экспорт аннотаций на сайт');
      ExportAnnos(tmpSab, aProgressor, l_NamesList, l_MissedNamesList);
      if l_MissedNamesList.Count > 0 then
       l_MissedNamesList.SaveToFile(MissedListFileName);
      // Экспорт документов от аннотаций
      l3System.Msg2Log('Экспорт документов от аннотаций');
      if f_Aborted then
        Exit;
      if not ExportDocsOnAnno(tmpSab2, aProgressor) then
       l_Msg := l_Msg + #13#10#13#10'К сожалению, документы не попали на сервер Прайма'
      else
      begin
       l_FileName := f_TaskParams.DocListFileName;
       // Проверить доступность папки
       l_ExportFolder := SafeValidFolder(f_TaskParams.DocListFolder);
       if l_FileName <> '' then
        l_FileName := ConcatDirName(l_ExportFolder, l_FileName);
       if l_FileName <> '' then
        l_NamesList.SaveToFile(l_FileName);
      end;
     end;
     // Отправка письма
     f_TaskResult.ReportMessage := l_Msg;
     f_TaskResult.ReportSubject := SalcuRequestService_Eksportannotaciy;
     f_TaskResult.NeedReport := f_TaskParams.eMailNotifyList <> '';
     f_TaskResult.NextDate := IncDay(l_FinishDate);
    end; // Result
   finally
    FreeAndNil(l_MissedNamesList);
   end;
  finally
   l3Free(l_NamesList);
  end;
 end;
end;

function TalcuPrime.ExportDocsOnAnno(const aDocs: ISab; aProgressor: TddProgressObject): Boolean;
var
 l_FileName, l_ExportFolder : String;
begin
 try
  if (aDocs.Count > 0) and not f_Aborted then
  begin
   l_FileName := f_TaskParams.DocListFileName;
   l_ExportFolder := SafeValidFolder(f_TaskParams.DocListFolder);
   if l_ExportFolder <> f_TaskParams.DocListFolder then
    l3System.Msg2Log('Неправильная папка для экспорта %s. Экспортируем в %s', [f_TaskParams.DocListFolder, l_ExportFolder]);
   if l_FileName <> '' then
    l_FileName := ConcatDirName(l_ExportFolder, l_FileName);
   with TddHTMLAnnotationPipe.Create(l_FileName) do
   try
    f_PipeToAbort := Pipe;
    Pipe.Family:= CurrentFamily;
    Pipe.DocSab:= aDocs;
    Pipe.ExportDirectory:= l_ExportFolder;
    Pipe.ExportDocTypes:= dtAll;
    Pipe.ExportReferences := False;
    ForceDirectories(Pipe.ExportDirectory);
    Pipe.Progressor := aProgressor;
    Result:= Execute;
   finally
    f_PipeToAbort := nil;
    Free;
   end;
  end;
 except
  on E:Exception do
  begin
   Result:= False;
   Exception2Log(E);
  end;
 end;
end;

function TalcuPrime.ExportAnnos(const aAnnos: ISab; aProgressor: TddProgressObject; aNamesList, aMissedNamesList:
 TStrings): Boolean;
var
 l_FileName, l_ExportFolder : String;
begin
 try
  if (aAnnos.Count > 0) and not f_Aborted then
  begin
   l_FileName := f_TaskParams.DocListFileName;
   l_ExportFolder := SafeValidFolder(f_TaskParams.DocListFolder);
   if l_ExportFolder <> f_TaskParams.DocListFolder then
    l3System.Msg2Log('Неправильная папка для экспорта %s. Экспортируем в %s', [f_TaskParams.DocListFolder, l_ExportFolder]);
   if l_FileName <> '' then
    l_FileName := ConcatDirName(l_ExportFolder, l_FileName);
   with TddHTMLAnnotationPipe1.Create(l_FileName) do
   try
    f_PipeToAbort := Pipe;
    Pipe.Family:= CurrentFamily;
    Pipe.DocSab := aAnnos;
    Pipe.ExportDirectory:= l_ExportFolder;
    Pipe.ExportAnnotation:= True;
    Pipe.ExportDocument:= False;
    Pipe.ExportDocTypes:= [dtAnnotation];
    ForceDirectories(Pipe.ExportDirectory);
    Pipe.Progressor := aProgressor;
    NamesList:= aNamesList;
    MissedNamesList:= aMissedNamesList;
    Result:= Execute;
   finally
    f_PipeToAbort := Nil;
    Free;
   end;
  end;
 except
  on E:Exception do
  begin
   Result:= False;
   Exception2Log(E);
  end;
 end;
end;

function TalcuPrime.LoadPrevDocs: ISab;
var
 l_Stream : TStream;
 l_Sab: ISab;
begin
 Result := nil;
 if FileExists(DocListFileName) then
 begin
  l_Stream := Tl3FileStream.Create(DocListFileName, l3_fmread);
  try
   DocumentServer.Family := CurrentFamily;
   Result := MakeValueSet(DocumentServer.FileTbl, fId_Fld, l_Stream);
   //Result.RecordsByKey;
  finally
   l3Free(l_Stream);
  end;
 end; // FileExists(DocListFileName)
end;

procedure TalcuPrime.MakeAnnodate(out StartDate, FinishDate: TDateTime);
var
 l_Day, l_Delta: Word;
 l_Today: TDateTime;
begin
 l_Day:= f_TaskParams.EndDateKind;
 l_Today:= Now;
 StartDate:= f_TaskParams.StartDate;
 if (CompareDate(StartDate, l_Today) = GreaterThanValue) and (l_Day <> 0) then
  l_Today:= StartDate;
 FinishDate:= GetNearestDay(l_Today, l_Day);
 if CompareDate(StartDate, FinishDate) = GreaterThanValue then
 begin
  l_Delta:= IfThen(l_Day = 0, 1, 7);
  StartDate := IncDay(StartDate, -l_Delta);
 end; // CompareDate(StartDate, FinishDate) = GreaterThanValue
end;

function TalcuPrime.MakeAnnoFileName(aFolder: String; aDate: TDateTime): string;
var
 l_DateStr, l_BelongsStr: String;
 l_List: Tl3LongintList;
begin
 DateTimeToString(l_DateStr, SalcuRequestService_YyyyMmDd, aDate);
 l_List:= Tl3LongintList.Create;
 try
  f_TaskParams.BelongsIDList.ToList(l_List);
  if (l_List <> nil) and not l_List.Empty then
  begin
   l_BelongsStr:= DictServer(CurrentFamily).Dict[da_dlBases].GetShortName(l_List.Items[0]);
   Result := ConcatDirName(aFolder, l_DateStr + '_' + l_BelongsStr + SalcuRequestService_Nsr);
  end
  else
   Result:= '';
 finally
   FreeAndNil(l_List);
 end;
end;

function TalcuPrime.MakeAnnotations(aFrom, aTo: TDateTime; out DocSab: ISab; out TodayList, AllDaysList, NamesList:
    TStrings): ISab;

var
 l_Anno, l_Finished, l_PrevAnno, l_Temp: TdtQuery;
 l_AllAnno: TdtQuery;
 l_Q : TdtQuery;
 l_Sab : ISab;
 l_List: Tl3LongintList;

 procedure FlushToList(aQuery: TdtQuery; aList: TStrings);
 var
  l_IteratorStub: TdtRecAccessProc;

  function l_Iterator(aRec: PIDFNameRec): Boolean;
  begin
   Result := True; // обрабатываем все записи
   with aRec^ do
    aList.Add(SysUtils.Format('%d'#9'%s', [LinkServer(CurrentFamily).ReNum.GetExtDocID(rDocID),
                                          l3ArrayToString(rName, cFullNameSize)]));
  end;

 begin
  if not aQuery.IsEmpty then
  begin
   l_IteratorStub := L2RecAccessProc(@l_Iterator);
   try
    aQuery.FoundList.IterateRecords(l_IteratorStub, [fId_Fld, fFName_Fld]);
   finally
    FreeRecAccessProc(l_IteratorStub);
   end;
  end;
 end;

begin
 l_Anno := TdtAndQuery.Create;
 try
  // выборка аннотаций строится с даты последнего экспорта + 1 по сегодня
  l_Q := TdtLogByActionQuery.Create(acAnnoDate,
                                    StDateToDemon(DateTimeToStDate(aFrom)),
                                    StDateToDemon(DateTimeToStDate(aTo)),
                                    0 {Любая группа пользователей},
                                    True {Ищем по группам});
  TdtAndQuery(l_Anno).AddQueryF(l_Q);
  // Нужно оставить только нужные аннотации - от выбранных Групп доументов
  l_List := Tl3LongintList.Create;
  try
   f_TaskParams.BelongsIDList.ToList(l_List);
   if l_List <> nil then
   begin
    l_Q := TdtDictQuery.Create(da_dlBases, l_List, False, True {WithSubTree});
    TdtAndQuery(l_Anno).AddQueryF(l_Q);
   end;
  finally
   FreeAndNil(l_List);
  end;

  Result := MakeSabCopy(l_Anno.FoundList);
  Result.ValuesOfKey(fId_Fld); // это не криво ли? Потом все равно превращается в RES_RECORD...

  //if f_TaskParams.ExportDocuments then
  begin
   {$IFNDEF Region}
   // Выкидываем группы доступа
   l_List:= Tl3LongintList.Create;
   try
    f_TaskParams.ExcludeAccGroupsIDList.ToList(l_List);
    if l_List <> nil then
    begin
     l_Q := TdtDictQuery.Create(da_dlAccGroups, l_List, False, True {WithSubTree});
     SQNot(l_Q);
     TdtAndQuery(l_Anno).AddQueryF(l_Q);
    end;
   finally
    FreeAndNil(l_List);
   end;
   {$ENDIF}
   // выборка Проекты законов
   l_List:= Tl3LongintList.Create;
   try
    f_TaskParams.AccGroupsIDList.ToList(l_List);
    if l_List <> nil then
    begin
     l_Q := TdtDictQuery.Create(da_dlAccGroups, l_List);
     SQNot(l_Q);
     TdtAndQuery(l_Anno).AddQueryF(l_Q);
    end;
   finally
    FreeAndNil(l_List);
   end;

   l_List:= Tl3LongintList.Create;
   try
    f_TaskParams.CommentsIDList.ToList(l_List);
    if l_List <> nil then
    begin
     l_Q := TdtDictQuery.Create(da_dlTypes, l_List, False, True {WithSubTree});
     SQNot(l_Q);
     TdtAndQuery(l_Anno).AddQueryF(l_Q);
    end;
   finally
    FreeAndNil(l_List);
   end;

   // Теперь нужно вычесть пару Группы документов-Тип

   l_Temp := TdtAndQuery.Create;

   l_List:= Tl3LongintList.Create;
   try
    f_TaskParams.ExcludeDocTypesIDList.ToList(l_List);
    if l_List <> nil then
    begin
     l_Q := TdtDictQuery.Create(da_dlTypes, l_List, False, True {WithSubTree});
     TdtAndQuery(l_Temp).AddQueryF(l_Q);
    end;
   finally
    FreeAndNil(l_List);
   end;

   l_List:= Tl3LongintList.Create;
   try
    f_TaskParams.ExcludeDocBasesIDList.ToList(l_List);
    if l_List <> nil then
    begin
     l_Q := TdtDictQuery.Create(da_dlBases, l_List, False, True {WithSubTree});
     TdtAndQuery(l_Temp).AddQueryF(l_Q);
    end;
   finally
    FreeAndNil(l_List);
   end;

   if not l_Temp.IsEmpty then
   begin
    SQNot(l_Temp);
    TdtAndQuery(l_Anno).AddQueryF(l_Temp);
   end
   else
    l3Free(l_Temp);

   // Поиск вычитанных за всю жизнь
   l_Finished := TdtStageQuery.Create(0, 0, stEdit, stfFinished);
   try
    // загружаем предыдущую выборку
    l_Sab := LoadPrevDocs;
    try
     if l_Sab <> nil then
      l_PrevAnno := TdtIDListQuery.CreateFrom(l_Sab)
     else
      l_PrevAnno := nil;
    finally
     l_Sab := nil;
    end;

    try
     // Формируем списки

     // Невычитанные сегодня
     l_Temp := TdtAndQuery.Create;
     try
      l_Q := MakeIDList(l_Anno);
      TdtAndQuery(l_Temp).AddQueryF(l_Q);

      l_Q := TdtNOTQuery.Create;
      TdtNOTQuery(l_Q).SubQuery := l_Finished;
      TdtAndQuery(l_Temp).AddQueryF(l_Q);

      FlushToList(l_Temp, TodayList); // выливаем в список
     finally
      l3Free(l_Temp);
     end;

     // Невычитанные за весь период
     if l_PrevAnno <> nil then
     begin
      l_Temp := TdtAndQuery.Create;
      try
       l_Q := MakeIDList(l_PrevAnno);
       TdtAndQuery(l_Temp).AddQueryF(l_Q);

       l_Q := TdtNOTQuery.Create;
       TdtNOTQuery(l_Q).SubQuery := l_Finished;
       TdtAndQuery(l_Temp).AddQueryF(l_Q);
       FlushToList(l_Temp, AllDaysList); // выливаем в список
      finally
       l3Free(l_Temp);
      end;
     end;

     // Формируем списки на выливку и сохранение
     l_AllAnno := TdtOrQuery.Create;
     try
      TdtOrQuery(l_AllAnno).AddQuery(l_Anno);
      if l_PrevAnno <> nil then
       TdtOrQuery(l_AllAnno).AddQuery(l_PrevAnno);
      FlushToList(l_AllAnno, NamesList); // выливаем в список

      l_Temp := TdtAndQuery.Create;
      try
       TdtAndQuery(l_Temp).AddQuery(l_AllAnno);
       TdtAndQuery(l_Temp).AddQuery(l_Finished);

       DocSab := MakeSabCopy(l_Temp.FoundList);
       DocSab.ValuesOfKey(fId_Fld);
      finally
       l3Free(l_Temp);
      end;

      l_Temp := TdtAndQuery.Create;
      try
       TdtAndQuery(l_Temp).AddQuery(l_AllAnno);
       l_Q := TdtNOTQuery.Create;
       TdtNOTQuery(l_Q).SubQuery := l_Finished;
       TdtAndQuery(l_Temp).AddQueryF(l_Q);
       SaveCurDocs(l_Temp.FoundList);
      finally
       l3Free(l_Temp);
      end;
     finally
      l3Free(l_AllAnno);
     end;
    finally
     l3Free(l_PrevAnno);
    end;
   finally
    l3Free(l_Finished);
   end;
  end
  //else
  // DocSab:= nil;
 finally
  l3Free(l_Anno);
 end;
end;

procedure TalcuPrime.SaveCurDocs(aSab: ISab);
var
 i: Integer;
 l_Stream : TStream;
 l_DocID: TDocID;
 l_IteratorStub : TdtRecAccessProc;

 function l_Iterator(aID: PDocID): Boolean;
 begin
  Result := True;
  l_Stream.Write(aID^, SizeOf(TDocID));
 end;

begin
 l_Stream := Tl3FileStream.Create(DocListFileName, l3_fmWrite);
 try
  l_IteratorStub := L2RecAccessProc(@l_Iterator);
  try
   aSab.IterateRecords(l_IteratorStub, [fId_Fld]);
  finally
   FreeRecAccessProc(l_IteratorStub);
  end;
 finally
  l3Free(l_Stream);
 end;
end;
(*
function TalcuPrimeLite.Execute(aProgressor: TddProgressObject): Boolean;
var
 l_Stream: Tl3FileStream;
 tmpSab, tmpSab2: ISab;
 l_DateStr, l_Msg: String;
 l_StartDate,
 l_FinishDate : TDateTime;
 //l_Params: TExpQueryRec;
 l_TodayList, l_AllDaysList: TStrings;
 l_NamesList: TStrings;
 i: Integer;
 l_FileName, l_ExportFolder, l_Attach: String;
 l_Result: Integer;
 l_ExeName: String;
begin
 Result:= False;
 // Собственно аннотации
 MakeAnnodate(l_StartDate, l_FinishDate);
 l3System.Msg2Log('Экспорт Прайм с %s по %s', [DateToStr(l_StartDate), DateToStr(l_FinishDate)]);
 l_FileName := MakeAnnoFileName(SafeValidFolder(f_TaskParams.TargetFolder), l_FinishDate);
 if l_FileName = '' then
 begin
  l_Msg:= 'Не задана группа документов, экспорт невозможен';
  l3System.Msg2Log(l_Msg);

  f_TaskResult.ReportMessage := l_Msg;
  f_TaskResult.ReportSubject := SalcuRequestService_Eksportannotaciy;
  f_TaskResult.NeedReport := f_TaskParams.eMailNotifyList <> '';
 end
 else
 begin
      tmpSab:= MakeAnnotations(l_StartDate, l_FinishDate, tmpSab2, l_TodayList, l_AllDaysList, l_NamesList);

      if tmpSab.Count > 0 then
      begin
       with TddAnnotationPipe.Create do
       try
        Pipe.Family:= CurrentFamily;
        Pipe.DocSab:= tmpSab;
        Pipe.ExportDirectory:= SafeValidFolder(f_TaskParams.TargetFolder);
        //ForceDirectories(Pipe.ExportDirectory);
        FileName := l_FileName;
        Pipe.Progressor := aProgressor;
        Execute;
       finally
        Free;
       end;
      end
      else
      begin
       l_Msg := SalcuRequestService_Spriskorbiemsoobtshayutonebyloek;
       Tl3FileStream.Create(l_FileName, l3_fmWrite).Free;
       l3System.Msg2Log(l_Msg);
      end;
 end;
end;

class procedure TalcuPrimeLite.MakeAnnodate(out StartDate, FinishDate: TDateTime);
var
 l_Day, l_Delta: Word;
 l_Today: TDateTime;
begin
 l_Day:= f_TaskParams.EndDateKind;
 l_Today:= Now;
 StartDate:= f_TaskParams.StartDate;
 if (CompareDate(StartDate, l_Today) = GreaterThanValue) and (l_Day <> 0) then
  l_Today:= StartDate;
 FinishDate:= GetNearestDay(l_Today, l_Day);
 if CompareDate(StartDate, FinishDate) = GreaterThanValue then
 begin
  l_Delta:= IfThen(l_Day = 0, 1, 7);
  StartDate := IncDay(StartDate, -l_Delta);
 end; // CompareDate(StartDate, FinishDate) = GreaterThanValue
end;

function TalcuPrimeLite.MakeAnnoFileName(aFolder: String; aDate: TDateTime): string;
var
 l_DateStr, l_BelongsStr: String;
 l_List: Tl3LongintList;
begin
 DateTimeToString(l_DateStr, SalcuRequestService_YyyyMmDd, aDate);
 l_List:= Tl3LongintList.Create;
 try
  f_TaskParams.BelongsIDList.ToList(l_List);
  if (l_List <> nil) and not l_List.Empty then
  begin
   l_BelongsStr:= DictServer(CurrentFamily).Dict[da_dlBases].GetShortName(l_List.Items[0]);
   Result := ConcatDirName(aFolder, l_DateStr + '_' + l_BelongsStr + SalcuRequestService_Nsr);
  end
  else
   Result:= '';
 finally
   FreeAndNil(l_List);
 end;

end;

function TalcuPrimeLite.MakeAnnotations(aFrom, aTo: TDateTime; out DocSab: ISab; out TodayList, AllDaysList, NamesList:
    TStrings): ISab;

var
 l_Anno, l_Finished, l_PrevAnno, l_Temp: TdtQuery;
 l_AllAnno: TdtQuery;
 l_Q : TdtQuery;
 l_Sab : ISab;
 l_List: Tl3LongintList;

 procedure FlushToList(aQuery: TdtQuery; aList: TStrings);
 var
  l_IteratorStub: TdtRecAccessProc;

  function l_Iterator(aRec: PIDFNameRec): Boolean;
  begin
   Result := True; // обрабатываем все записи
   with aRec^ do
    aList.Add(SysUtils.Format('%d'#9'%s', [LinkServer(CurrentFamily).ReNum.GetExtDocID(rDocID),
                                          l3ArrayToString(rName, cFullNameSize)]));
  end;

 begin
  if not aQuery.IsEmpty then
  begin
   l_IteratorStub := L2RecAccessProc(@l_Iterator);
   try
    aQuery.FoundList.IterateRecords(l_IteratorStub, [fId_Fld, fFName_Fld]);
   finally
    FreeRecAccessProc(l_IteratorStub);
   end;
  end;
 end;

begin
 l_Anno := TdtAndQuery.Create;
 try
  // выборка аннотаций строится с даты последнего экспорта + 1 по сегодня
  l_Q := TdtLogByActionQuery.Create(acAnnoDate,
                                    StDateToDemon(DateTimeToStDate(aFrom)),
                                    StDateToDemon(DateTimeToStDate(aTo)),
                                    0 {Любая группа пользователей},
                                    True {Ищем по группам});
  TdtAndQuery(l_Anno).AddQueryF(l_Q);
  // Нужно оставить только нужные аннотации - от выбранных Групп доументов
  l_List:= Tl3LongintList.Create;
  try
   f_TaskParams.BelongsIDList.ToList(l_List);

   if l_List <> nil then
   begin
    l_Q := TdtDictQuery.Create(da_dlBases, l_List, False, True {WithSubTree});
    TdtAndQuery(l_Anno).AddQueryF(l_Q);
   end;
  finally
   FreeAndNil(l_List);
  end;
  Result := MakeSabCopy(l_Anno.FoundList);
  Result.ValuesOfKey(fId_Fld); // это не криво ли? Потом все равно превращается в RES_RECORD...

 finally
  l3Free(l_Anno);
 end;
end;
*)

procedure TalcuPrime.Cleanup;
begin
 FreeAndNil(f_TaskParams);
 FreeAndNil(f_TaskResult);
 inherited Cleanup;
end;

constructor TalcuPrime.Create(const aParams: TcsAnnotationTask;
  const aResult: TalcuAnnotationTaskResult);
begin
 inherited Create;
 aParams.SetRefTo(f_TaskParams);
 aResult.SetRefTo(f_TaskResult);
end;

procedure TalcuPrime.AbortProcess;
begin
  f_Aborted := True;
  if Assigned(f_PipeToAbort) then
    f_PipeToAbort.Aborted := True;
end;

end.

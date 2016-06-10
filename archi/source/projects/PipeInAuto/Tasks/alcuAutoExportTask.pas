unit alcuAutoExportTask;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 ddProcessTaskPrim,

 csProcessTask,
 csTaskResult,

 alcuAutoExportTaskPrim,
 alcuAutoExport,
 alcuAutoExportTaskResult
 ;

type
 TalcuAutoExportTask = class(TalcuAutoExportTaskPrim)
 private
  f_Exporter: TalcuAutoExporter;
  procedure _OnReportEmpty(aSender: TObject; aEmptyCount: Integer);
  procedure _OnTotalCount(aTotalCount: Integer);
  function pm_GetTaskResult: TalcuAutoExportTaskResult;
 protected
  procedure DoAbort; override;
  procedure DoRun(const aContext: TddRunContext); override;
  function GetTaskResultClass: TcsTaskResultClass; override;
  {$If defined(AppServerSide)}
  procedure DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
  function NeedNotifySender: Boolean; virtual;
  function NeedCorrectLastDate: Boolean; virtual;
  {$If defined(AppServerSide)}
  procedure CalcDates; virtual;
  {$IfEnd defined(AppServerSide)}
  function AllowSimultaneousRun: Boolean; override;
  function NeedSendCheckReport: Boolean; virtual;
 public
  class function CanAsyncRun: Boolean; override;
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
  property TaskResult: TalcuAutoExportTaskResult read pm_GetTaskResult;
 end;

implementation

uses
 SysUtils,
 DateUtils,
 StrUtils,

 l3LongintList,

 daUtils,
 dt_Types,

 evdDTTypes,

 csTaskTypes,

 ddServerTask,
 {$If defined(AppServerSide)}
 ddAppConfig,
 ddScheduler,
 ddCalendarEvents,
 {$IfEnd defined(AppServerSide)}

 alcuMailServer,
 alcuTypes
 ;


{ TalcuAutoExportTask }

function TalcuAutoExportTask.AllowSimultaneousRun: Boolean;
begin
 Result := False;
end;

  {$If defined(AppServerSide)}
procedure TalcuAutoExportTask.CalcDates;
var
 l_NextCompilation, l_VersionDate: TDateTime;
begin
 Today:= Now;
 CompileDate:= IncDay(Today, -1);
 VersionDate:= Today;

 case ddAppConfiguration.AsInteger['aeStartDate'] of
  0:
   begin
    if TddScheduler(ddAppConfiguration.AsObject['Scheduler']).GetPrevFullDateTime(ctCompilation, Today, l_NextCompilation) then
     CompileDate := l_NextCompilation;
(*
    l_TaskCom:= TddScheduler(ddAppConfiguration.AsObject['Scheduler']).GetTaskByTaskType(ctCompilation);
    if l_TaskCom <> nil then
     CompileDate:= l_TaskCom.PrevFullDateTime[Today];
*)
   end; // с даты предыдущей компиляции
  1: CompileDate:= IncDay(Today, -1); // со вчера
  2: CompileDate:= ddAppConfiguration.AsDateTime['aeLastDate'];
  3: CompileDate:= IncDay(Today, -2); // за последние два дня
  4: CompileDate:= ddAppConfiguration.AsDateTime['aeCustomStartDate'];
 end; // ddAppConfiguration.AsInteger['aeStartDate']

 l_NextCompilation := Today;
 TddScheduler(ddAppConfiguration.AsObject['Scheduler']).GetFullDateTime(ctCompilation, Today, l_NextCompilation);
 if TddScheduler(ddAppConfiguration.AsObject['Scheduler']).GetFullDateTime(ctVersion, l_NextCompilation, l_VersionDate) then
  VersionDate := l_VersionDate;
(*
 //ctVersion, ctCompilation
 l_TaskVer:= TddScheduler(ddAppConfiguration.AsObject['Scheduler']).GetTaskByTaskType(ctVersion);
 if l_TaskVer <> nil then
 begin
  l_TaskCom:= TddScheduler(ddAppConfiguration.AsObject['Scheduler']).GetTaskByTaskType(ctCompilation);
  if l_TaskCom <> nil then
   l_NextCompilation:= l_TaskCom.FullDateTime[Today]
  else
   l_NextCompilation:= Today;
  VersionDate:= l_TaskVer.FullDateTime[l_NextCompilation];
 end; // l_TaskVer <> nil
*)
end;
  {$IfEnd defined(AppServerSide)}

class function TalcuAutoExportTask.CanAsyncRun: Boolean;
begin
 Result := True;
end;

procedure TalcuAutoExportTask.DoAbort;
begin
  inherited;
  if Assigned(f_Exporter) then
    f_Exporter.AbortProcess;
end;

procedure TalcuAutoExportTask.DoRun(const aContext: TddRunContext);
begin
 f_Exporter := TalcuAutoExporter.Create(Self, TaskResult);
 with f_Exporter do { TODO : Нужно вынести это в настройки }
 try
  if NeedSendCheckReport then
  begin
   OnReportEmpty := _OnReportEmpty;
   OnTotalCount := _OnTotalCount;
  end;
  Execute(aContext.rProgressor);
 finally
  FreeAndNil(f_Exporter);
 end;
end;

  {$If defined(AppServerSide)}
procedure TalcuAutoExportTask.DoRunSuccessfullyFinished(
  const aServices: IcsRunTaskServices);
const
 cResultMap: array [Boolean] of String = ('с ошибками', 'успешно');  
begin
 inherited;
 if TaskResult.ReportMessage <> '' then
 begin
   alcuMail.SendEmail(eMailNotifyList, TaskResult.ReportMessage, Description + IfThen(TaskResult.IsSuccess, '. Результаты', '. ОШИБКИ'));
   alcuMail.SendEmail(SMSNotifyList, 'Автоматический экспорт завершен', 'Autoexport');
 end;
 if NeedCorrectLastDate then
 begin
  ddAppConfiguration.AsDateTime['aeLastDate']:= Today;
  ddAppConfiguration.Save;
 end;
 if IsUserRequireReports(UserID) and NeedNotifySender then
   aServices.SendTextMessage(UserID, Format('Задача %s завершена %s.',[Description, cResultMap[TaskResult.IsSuccess]]));
end;
  {$IfEnd defined(AppServerSide)}

function TalcuAutoExportTask.GetTaskResultClass: TcsTaskResultClass;
begin
 Result := TalcuAutoExportTaskResult;
end;

function TalcuAutoExportTask.NeedCorrectLastDate: Boolean;
begin
  Result := True;
end;

function TalcuAutoExportTask.NeedNotifySender: Boolean;
begin
  Result := True;
end;

function TalcuAutoExportTask.NeedSendCheckReport: Boolean;
begin
 Result := True;
end;

function TalcuAutoExportTask.pm_GetTaskResult: TalcuAutoExportTaskResult;
begin
 Result := TalcuAutoExportTaskResult(inherited TaskResult);
end;

  {$If defined(AppServerSide)}
procedure TalcuAutoExportTask.SetupServerSideConfigParams;
begin
 inherited;

 OutFormat := outNSRC;
 {$IF Defined(LUK) or Defined(SGC)}
 Stages := [aeInfo];
 {$ELSE Defined(LUK) or Defined(SGC)}
 Stages := [aeAnnotations, aeIncluded, aeChanged, aeInfo];
 {$IFEND}

 CalcDates;

 {$IF not Defined(LUK) and not Defined(SGC)}
 {$IFDEF AEbyBelongs}
 AccGroupsIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['aiChangedBases']));
 {$ELSE}
 AccGroupsIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['aiAccGroups']));
 {$ENDIF}
 AnnoTemplate := ddAppConfiguration.AsString['aiAnnoTemplate'];
 BasesIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['aiBases']));
 {$IFEND not Defined(LUK) and not Defined(SGC)}
 {$IF not Defined(LUK) and not Defined(SGC)}
 ChangedDocTemplate := ddAppConfiguration.AsString['aiChangedDocTemplate'];
 ChangedRelTempate := ddAppConfiguration.AsString['aiChangedRelTemplate'];
 ExpandEditions := ddAppConfiguration.AsBoolean['aiExpandEditions'];
 {$IFEND not Defined(LUK) and not Defined(SGC)}
 ExecName := ddAppConfiguration.AsString['aiExecute'];
 ExecParams := ddAppConfiguration.AsString['aiParams'];
 {$IFNDEF AEByBelongs}
 {$IF Defined(LUK) or Defined(SGC)}
 DoneFileName := '';
 {$ELSE}
 DoneFileName := ddAppConfiguration.AsString['DoneFileName'];
 {$IFEND}
 {$ENDIF}
 ExportFolder := ddAppConfiguration.AsString['AutoIncludedFolder'];
 {$IF not Defined(LUK) and not Defined(SGC)}
 IncludedDocTemplate := ddAppConfiguration.AsString['aiNewDocTemplate'];
 IncludedRelTemplate := ddAppConfiguration.AsString['aiNewRelTemplate'];
 {$IFEND not Defined(LUK) and not Defined(SGC)}
 InfoDocTemplate := ddAppConfiguration.AsString['aiAllDocTemplate'];
 {$IFDEF AEByBelongs}
 InfoIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['aiFullBases']));
 {$ELSE}
 InfoIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['aiFullAccGroups']));
 {$ENDIF}
 InfoRelTemplate := ddAppConfiguration.AsString['aiAllRelTemplate'];
 NeedTopicList := True;
 {$IF not Defined(LUK) and not Defined(SGC)}
 InfoDocsIncludedOnly := ddAppConfiguration.AsBoolean['aiAllExportIncluded'];
 eMailNotifyList := ddAppConfiguration.AsString['aiNotifyList'];
 {$IFEND not Defined(LUK) and not Defined(SGC)}
 PartSize := ddAppConfiguration.AsInteger['AutoIncludedSize'];
 {$IFDEF aiSMSNotify}
 SMSNotifyList := ddAppConfiguration.AsString['aiSMSNotify'];
 {$ELSE}
 SMSNotifyList := '';
 {$ENDIF}
 {$IF not Defined(LUK) and not Defined(SGC)}
 MaxExportCount := ddAppConfiguration.AsInteger['aiTotalCount'];
 {$IFEND not Defined(LUK) and not Defined(SGC)}
end;
  {$IfEnd defined(AppServerSide)}

procedure TalcuAutoExportTask._OnReportEmpty(aSender: TObject; aEmptyCount: Integer);
begin
 alcuMail.SendEmailNotify(eventEmptyDocuments, True,
                          Format('Обнаружены пустые документы в количестве %d штук', [aEmptyCount]),
                          dd_apsExport);
end;

procedure TalcuAutoExportTask._OnTotalCount(aTotalCount: Integer);
var
 l_Msg: String;
begin
 {$IF not Defined(LUK) and not Defined(SGC)}
 if aTotalCount > MaxExportCount then
 begin
  l_Msg:= Format('Количество документов %d превышает установленный лимит %d. Будьте внимательны, возможно увеличение времени экспорта.',
                 [aTotalCount, MaxExportCount]);
  alcuMail.SendEmail(eMailNotifyList, l_Msg, 'Превышение объема автовыливки', True);
 end;
 {$IFEND}
end;

initialization
 RegisterTaskClass(cs_ttAExportDoc, TalcuAutoExportTask, 'Автоматический экспорт документов и аннотаций');

end.
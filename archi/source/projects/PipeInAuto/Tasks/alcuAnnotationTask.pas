unit alcuAnnotationTask;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(ServerTasks)}
uses
  Classes,

  ddProcessTaskPrim,

  csTaskResult,
  csProcessTask,
  {$If not defined(Nemesis)}
  csAnnotationTask,
  {$IfEnd} //not Nemesis

  dt_Types,

  alcuPrime,
  alcuAnnotationTaskResult
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuAnnotationTask = class(TcsAnnotationTask)
 private
  f_Prime: TalcuPrime;
  function pm_GetTaskResult: TalcuAnnotationTaskResult;
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
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
  property TaskResult: TalcuAnnotationTaskResult read pm_GetTaskResult;
 end;//TalcuAnnotationTask
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
 SysUtils,

 l3LongintList,

 csTaskTypes,

 ddServerTask,
 {$If defined(AppServerSide)}
 ddAppConfig,
 {$IfEnd defined(AppServerSide)}

 daInterfaces,

 alcuMailServer,
 alcuStrings;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
{ TalcuAnnotationTask }

function TalcuAnnotationTask.AllowSimultaneousRun: Boolean;
begin
  Result := False;
end;

class function TalcuAnnotationTask.CanAsyncRun: Boolean;
begin
  Result := True;
end;

procedure TalcuAnnotationTask.DoAbort;
begin
 inherited DoAbort;
 if f_Prime <> nil then
  f_Prime.AbortProcess;
end;

procedure TalcuAnnotationTask.DoRun(const aContext: TddRunContext);
begin
 f_Prime := TalcuPrime.Create(Self, TaskResult);
 try
  f_Prime.Execute(aContext.rProgressor);
 finally
  FreeAndNil(f_Prime);
 end;
end;

{$If defined(AppServerSide)}
procedure TalcuAnnotationTask.DoRunSuccessfullyFinished(
  const aServices: IcsRunTaskServices);
var
  l_Attach: TStrings;
  l_IDX: Integer;
begin
  inherited;
  if TaskResult.NeedSendToRobot then
  begin
   if TaskResult.RobotAttach <> '' then
   begin
     l_Attach := TStringList.Create;
     l_Attach.Text := TaskResult.RobotAttach;
   end
   else
     l_Attach := nil;
   try
    if alcuMail.SendEmail(PrimeRobotEMail, 'Автоматический Прайм',
      TaskResult.RobotMessage, False, l_Attach) then
    begin
      for l_IDX := 0 to l_Attach.Count - 1 do
        DeleteFile(l_Attach[l_IDX]);
    end;
   finally
    FreeAndNil(l_Attach);
   end;
  end;
  if TaskResult.NeedReport then
  begin
   if TaskResult.ReportAttach <> '' then
   begin
     l_Attach := TStringList.Create;
     l_Attach.Text := TaskResult.ReportAttach;
   end
   else
     l_Attach := nil;
   try
    alcuMail.SendEmail(eMailNotifyList, TaskResult.ReportMessage,
      TaskResult.ReportSubject, not TaskResult.IsSuccess, l_Attach);
   finally
    FreeAndNil(l_Attach);
   end;
  end;
  if TaskResult.IsSuccess then
  begin
   ddAppConfiguration.AsDateTime['annoDate']:= TaskResult.NextDate;
   ddAppConfiguration.Save;
  end;
end;
{$IfEnd defined(AppServerSide)}

function TalcuAnnotationTask.GetTaskResultClass: TcsTaskResultClass;
begin
  Result := TalcuAnnotationTaskResult;
end;

function TalcuAnnotationTask.pm_GetTaskResult: TalcuAnnotationTaskResult;
begin
  Result := TalcuAnnotationTaskResult(inherited TaskResult);
end;

  {$If defined(AppServerSide)}
procedure TalcuAnnotationTask.SetupServerSideConfigParams;
begin
  inherited;
  NeedAnalyzeLog := ddAppConfiguration.AsBoolean['annoAnalyzeLog'];
  TargetFolder := ddAppConfiguration.AsString[SalcuRequestService_AnnoFolder];
  eMailNotifyList := ddAppConfiguration.AsString[SalcuRequestService_AnnoInfoList];
  ExternalProcessor := ddAppConfiguration.AsString['annoExecute'];
  OutFolder := ddAppConfiguration.AsString['annoOutFolder'];
  PrimeRobotEMail := ddAppConfiguration.AsString['annoPrimeEmail'];
  ExportDocuments := ddAppConfiguration.AsBoolean['annoNeedDocs'];
  DocListFileName := ddAppConfiguration.AsString[SalcuRequestService_AnnoDocListFile];
  DocListFolder := ddAppConfiguration.AsString[SalcuRequestService_AnnoDocFolder];
  EndDateKind := ddAppConfiguration.AsInteger['annoEndDate'];
  StartDate := ddAppConfiguration.AsDateTime['annoDate'];
  if Tl3LongintList(ddAppConfiguration.AsObject['annoBelongs']) <> nil then
    BelongsIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['annoBelongs']));
{$IFNDEF Region}
  if Tl3LongintList(ddAppConfiguration.AsObject['annoAccGroup']) <> nil then
    ExcludeAccGroupsIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['annoAccGroup']));
{$ENDIF Region}
  if Tl3LongintList(ddAppConfiguration.AsObject['annoProjects']) <> nil then
    AccGroupsIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['annoProjects']));
  if Tl3LongintList(ddAppConfiguration.AsObject['annoComments']) <> nil then
    CommentsIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['annoComments']));
  if Tl3LongintList(ddAppConfiguration.AsObject['annoProjects3']) <> nil then
    ExcludeDocTypesIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['annoProjects3']));
  if Tl3LongintList(ddAppConfiguration.AsObject['annoProjects2']) <> nil then
    ExcludeDocBasesIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['annoProjects2']));
end;
  {$IfEnd defined(AppServerSide)}


{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
initialization
 RegisterTaskClass(cs_ttAnnoExport, TalcuAnnotationTask, 'Экспорт Прайм');
{$IfEnd} //ServerTasks

end.
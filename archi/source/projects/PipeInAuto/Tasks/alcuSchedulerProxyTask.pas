unit alcuSchedulerProxyTask;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
  Classes,

  {$If defined(AppServerSide)} ddScheduler, {$IfEnd defined(AppServerSide)}

  ddProcessTaskPrim,

  csProcessTask,
  csSchedulerProxyTask
  ;

type
 TalcuSchedulerProxyTask = class(TcsSchedulerProxyTask)
 private
  {$If defined(AppServerSide)}
   f_ParentTask: TddSchedulerTask;
   procedure pm_SetParentTask(const Value: TddSchedulerTask);
  {$IfEnd defined(AppServerSide)}
 protected
  procedure DoRun(const aContext: TddRunContext); override;
  function AllowSimultaneousRun: Boolean; override;
  {$If defined(AppServerSide)}
  procedure Cleanup; override;
  {$IfEnd defined(AppServerSide)}
 public
  class function CanAsyncRun: Boolean; override;
  {$If defined(AppServerSide)}
  property ParentTask: TddSchedulerTask read f_ParentTask write pm_SetParentTask;
  {$IfEnd defined(AppServerSide)}
 end;//TalcuMdpImportDocs

implementation

uses
 SysUtils,

 csTaskTypes,

 {$If defined(AppServerSide)} ddAppConfig, alcuStrings, ddCalendarEvents, {$IfEnd defined(AppServerSide)}
 ddServerTask
 ;


{ TalcuMdpImportDocs }

function TalcuSchedulerProxyTask.AllowSimultaneousRun: Boolean;
begin
 Result := False;
end;

class function TalcuSchedulerProxyTask.CanAsyncRun: Boolean;
begin
 Result := False;
end;

{$If defined(AppServerSide)}
procedure TalcuSchedulerProxyTask.Cleanup;
begin
 FreeAndNil(f_ParentTask);
 inherited;
end;
{$IfEnd defined(AppServerSide)}

procedure TalcuSchedulerProxyTask.DoRun(const aContext: TddRunContext);
begin
{$If defined(AppServerSide)}
 (ddAppConfiguration.AsObject[SalcuAutoPipeServer_Scheduler] as TddSCheduler).ManualExecuteTaskByType(ParentTask, TddCalendarTaskType(SchedulerTaskType));
{$Else defined(AppServerSide)}
 raise Exception.Create'Задача %s должна работать в синхронном режиме.', [Description]);
{$IfEnd defined(AppServerSide)}
end;

  {$If defined(AppServerSide)}
procedure TalcuSchedulerProxyTask.pm_SetParentTask(
  const Value: TddSchedulerTask);
begin
 Value.SetRefTo(f_ParentTask);
end;
{$IfEnd defined(AppServerSide)}

initialization
 RegisterTaskClass(cs_ttSchedulerProxy, TalcuSchedulerProxyTask, 'Задание планировщика');

end.

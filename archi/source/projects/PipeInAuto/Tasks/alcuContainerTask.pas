unit alcuContainerTask;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
  Classes,

  ddProcessTaskPrim,

  csProcessTask,
  csContainerTask
  ;

type
 TalcuContainerTask = class(TcsContainerTask)
 private
{$If defined(AppServerSide)}
  procedure WaitForTask(const aTask: TddProcessTask);
{$IfEnd defined(AppServerSide)}
  function IsSubTaskOf(const aTask: TddProcessTask): Boolean;
 protected
  procedure DoRun(const aContext: TddRunContext); override;
  procedure DoAbort; override;
  function AllowSimultaneousRun: Boolean; override;
  function CanSimultaneousRunWith(const aTask: TddProcessTask): Boolean; override;
 public
  class function CanAsyncRun: Boolean; override;
  procedure CorrectStatus; override;
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
 end;//TalcuMdpImportDocs

implementation

uses
 SysUtils,
 l3Variant,
 Task_Const,

 csTaskTypes,

 {$If defined(AppServerSide)}
 ddAppConfig,
 Forms,
 evdTaskTypes,
 Windows,
 alcuServer,
 {$IfEnd defined(AppServerSide)}
 csTasksHelpers,
 ddServerTask
 ;


{ TalcuMdpImportDocs }

function TalcuContainerTask.AllowSimultaneousRun: Boolean;
begin
 Result := False;
end;

class function TalcuContainerTask.CanAsyncRun: Boolean;
begin
 Result := False;
end;

function TalcuContainerTask.CanSimultaneousRunWith(
  const aTask: TddProcessTask): Boolean;
begin
 if (aTask.TaskID <> TaskID) and (aTask is TalcuContainerTask) then
  Result := IsSubTaskOf(aTask)
 else
  Result := inherited CanSimultaneousRunWith(aTask)
end;

procedure TalcuContainerTask.CorrectStatus;
var
 l_List: TasksListHelper;
 l_Task: TddProcessTask;
 l_IDX: Integer;
begin
 inherited;
 l_List := TasksList;
 try
  for l_IDX := 0 to l_List.Count - 1 do
  begin
   l_Task := l_List.MakeTask(l_IDX, '');
   try
    l_Task.CorrectStatus;
   finally
    FreeAndNil(l_Task);
   end;
  end;
 finally
  l_List := nil;
 end;
end;

procedure TalcuContainerTask.DoAbort;
var
 l_List: TasksListHelper;
 l_Task: TddProcessTask;
 l_IDX: Integer;
begin
 inherited;
 l_List := TasksList;
 try
  for l_IDX := 0 to l_List.Count - 1 do
  begin
   l_Task := l_List.MakeTask(l_IDX, '');
   try
    l_Task.Abort;
   finally
    FreeAndNil(l_Task);
   end;
  end;
 finally
  l_List := nil;
 end;
end;

procedure TalcuContainerTask.DoRun(const aContext: TddRunContext);
var
 l_List: TasksListHelper;
 l_Task: TddProcessTask;
 l_IDX: Integer;
begin
{$If defined(AppServerSide)}
 l_List := TasksList;
 try
  if Assigned(aContext.rProgressor) then
   aContext.rProgressor.Start(l_List.Count + 1);
  try
   for l_IDX := 0 to l_List.Count - 1 do
   begin
    if Aborted then
     Break;
    l_Task := l_List.MakeTask(l_IDX, '');
    try
     l_Task.Owner := Self;
     SetProgress(RunProgress, Format('Подзадача: %s', [l_Task.Description]));
     l_Task.RequestQuery;
     TalcuServer.Instance.TaskProcessor.ForceExecuteTask(l_Task);
     if Assigned(aContext.rProgressor) then
     begin
      aContext.rProgressor.IncProgress(1);
      SetProgress(aContext.rProgressor.TotalPercent, RunComment);
     end;
     if not ParallelExecutionMode then
      WaitForTask(l_Task);
     if l_Task.Status in cs_tsErrorStatuses then
     begin
      Error(l_Task.Comment);
      break;
     end;
    finally
     FreeAndNil(l_Task);
    end;
   end;
   if ParallelExecutionMode then
    for l_IDX := 0 to l_List.Count - 1 do
    begin
     l_Task := l_List.MakeTask(l_IDX, '');
     try
      if l_Task.Status in cs_tsRunningStatuses then
       WaitForTask(l_Task);
      if l_Task.Status in cs_tsErrorStatuses then
      begin
       Error(l_Task.Comment);
       break;
      end;
     finally
      FreeAndNil(l_Task);
     end;
    end;
   if Assigned(aContext.rProgressor) then
   begin
    aContext.rProgressor.IncProgress(1);
    SetProgress(aContext.rProgressor.TotalPercent, '');
   end;
  finally
   if Assigned(aContext.rProgressor) then
    aContext.rProgressor.Stop;
  end;
 finally
  l_List := nil;
 end;
{$Else defined(AppServerSide)}
 raise Exception.Create'Задача %s должна работать в синхронном режиме.', [Description]);
{$IfEnd defined(AppServerSide)}
end;

{$If defined(AppServerSide)}
function TalcuContainerTask.IsSubTaskOf(
  const aTask: TddProcessTask): Boolean;
var
 l_Task: TddProcessTask;
 l_TaskID: String;
begin
 Result := False;
 l_Task := Self;
 l_TaskID := aTask.TaskID;
 while (l_Task <> nil) and l_Task.IsValid do
 begin
  if l_Task.TaskID = l_TaskID then
  begin
   Result := True;
   Exit;
  end;
  l_Task := l_Task.Owner as TddProcessTask;
 end;
end;

procedure TalcuContainerTask.SetupServerSideConfigParams;
var
 l_List: TasksListHelper;
 l_Task: TddProcessTask;
 l_IDX: Integer;
begin
 inherited;
 l_List := TasksList;
 try
  for l_IDX := 0 to l_List.Count - 1 do
  begin
   l_Task := l_List.MakeTask(l_IDX, '');
   try
    l_Task.SetupServerSideConfigParams;
   finally
    FreeAndNil(l_Task);
   end;
  end;
 finally
  l_List := nil;
 end;
end;
{$IfEnd defined(AppServerSide)}

{$If defined(AppServerSide)}
procedure TalcuContainerTask.WaitForTask(const aTask: TddProcessTask);
begin
 while not (aTask.Status in cs_tsFinishedStatuses) do
 begin
  Application.ProcessMessages;
  Sleep(0);
 end;
end;
{$IfEnd defined(AppServerSide)}

initialization
 RegisterTaskClass(cs_ttContainer, TalcuContainerTask, 'Групповая задача');

end.

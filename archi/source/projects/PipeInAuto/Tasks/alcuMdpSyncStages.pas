unit alcuMdpSyncStages;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_COMPLETED_alcuMdpSyncStages.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpSyncStages" MUID: (573D9F0A01BB)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , ddProcessTaskPrim
 , csMdpSyncStages
 , l3IniFile
 , l3BaseStream, csProcessTask;

type
 TalcuMdpSyncStages = class(TcsMdpSyncStages)
 private
  procedure DoSyncStages;
 protected
  procedure DoRun(const aContext: TddRunContext); override;
 public
  class function CanAsyncRun: Boolean; override;
  function CanSimultaneousRunWith(const aTask: TddProcessTask): Boolean; override;
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
 end;//TalcuMdpSyncStages
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 Classes,
 SysUtils,
 alcuMdpStagesSyncronizer,
 csTaskTypes,
 ddServerTask,
 l3ImplUses
 {$If defined(AppServerSide)},alcuMdpSyncParamUtils{$IfEnd defined(AppServerSide)}
;

{ TalcuMdpSyncStages }

class function TalcuMdpSyncStages.CanAsyncRun: Boolean;
begin
 Result := True;
end;

procedure TalcuMdpSyncStages.DoRun(const aContext: TddRunContext);
begin
 inherited;
{$If defined(AppServerSide)}
 Error(Format('Задача %s должна работать в асинхронном режиме.', [Description]));
{$Else defined(AppServerSide)}
 DoSyncStages;
{$IfEnd defined(AppServerSide)}
end;

procedure TalcuMdpSyncStages.DoSyncStages;
var
 l_Syncronizer : TalcuMdpStagesSyncronizer;
begin
 l_Syncronizer := TalcuMdpStagesSyncronizer.Create(Self);
 try
  l_Syncronizer.Execute;
 finally
  FreeAndNil(l_Syncronizer);
 end;
end;

function TalcuMdpSyncStages.CanSimultaneousRunWith(const aTask: TddProcessTask): Boolean;
begin
 Result := (aTask = Self) or (ClassName <> aTask.ClassName);
end;

{$If defined(AppServerSide)}
procedure TalcuMdpSyncStages.SetupServerSideConfigParams;
begin
 inherited;
 SetupMdpSyncParams(Self);
end;
{$IfEnd defined(AppServerSide)}

initialization
 RegisterTaskClass(cs_ttMdpSyncStages, TalcuMdpSyncStages, 'Синхронизация этапов в Гардок');
{$IfEnd defined(ServerTasks)}

end.

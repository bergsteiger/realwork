unit alcuMdpSyncImport;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_COMPLETED_alcuMdpSyncStages.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpSyncImport" MUID: (573D9F0A01BB)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , ddProcessTaskPrim
 , csMdpSyncImport
 , l3IniFile
 , l3BaseStream, csProcessTask;

type
 TalcuMdpSyncImport = class(TcsMdpSyncImport)
 private
  procedure DoSyncImport;
 protected
  procedure DoRun(const aContext: TddRunContext); override;
 public
  class function CanAsyncRun: Boolean; override;
  function CanSimultaneousRunWith(const aTask: TddProcessTask): Boolean; override;
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
 end;//TalcuMdpSyncImport
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 Classes,
 SysUtils,
 alcuMdpImportSyncronizer,
 csTaskTypes,
 ddServerTask,
 l3ImplUses
 {$If defined(AppServerSide)},alcuMdpSyncParamUtils{$IfEnd defined(AppServerSide)}
;

{ TalcuMdpSyncImport }

class function TalcuMdpSyncImport.CanAsyncRun: Boolean;
begin
 Result := True;
end;

procedure TalcuMdpSyncImport.DoRun(const aContext: TddRunContext);
begin
 inherited;
{$If defined(AppServerSide)}
 Error(Format('Задача %s должна работать в асинхронном режиме.', [Description]));
{$Else defined(AppServerSide)}
 DoSyncImport;
{$IfEnd defined(AppServerSide)}
end;

procedure TalcuMdpSyncImport.DoSyncImport;
var
 l_Syncronizer : TalcuMdpImportSyncronizer;
begin
 l_Syncronizer := TalcuMdpImportSyncronizer.Create(Self);
 try
  l_Syncronizer.Execute;
 finally
  FreeAndNil(l_Syncronizer);
 end;
end;

function TalcuMdpSyncImport.CanSimultaneousRunWith(const aTask: TddProcessTask): Boolean;
begin
 Result := (aTask = Self) or (ClassName <> aTask.ClassName);
end;

{$If defined(AppServerSide)}
procedure TalcuMdpSyncImport.SetupServerSideConfigParams;
begin
 inherited;
 SetupMdpSyncParams(Self);
end;
{$IfEnd defined(AppServerSide)}

initialization
 RegisterTaskClass(cs_ttMdpSyncImport, TalcuMdpSyncImport, 'Синхронизация журнала импортов в Гардок');
{$IfEnd defined(ServerTasks)}

end.

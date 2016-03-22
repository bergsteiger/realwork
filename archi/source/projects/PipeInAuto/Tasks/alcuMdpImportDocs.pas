unit alcuMdpImportDocs;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuMdpImportDocs.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuMdpImportDocs
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
  Classes,

  ddProcessTaskPrim,

  csProcessTask,
  csMdpImportDocs

{$IFDEF MDPSyncIntegrated}
  , alcuMDP
{$ENDIF MDPSyncIntegrated}
  ;

type
 TalcuMdpImportDocs = class(TcsMdpImportDocs)
 private
{$IFDEF MDPSyncIntegrated}
  f_Syncronizer: TalcuMDPSyncronizer;
{$ENDIF MDPSyncIntegrated}
 protected
  procedure DoRun(const aContext: TddRunContext); override;
  procedure DoAbort; override;
 public
  class function CanAsyncRun: Boolean; override;
  function IgnoreStrangeExitCode: Boolean; override;
  function CanSimultaneousRunWith(const aTask: TddProcessTask): Boolean; override;
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
  function IsHiddenFromUser: Boolean; override;
 end;//TalcuMdpImportDocs

implementation

uses
 SysUtils,

 csTaskTypes,

 {$If defined(AppServerSide)} ddAppConfig, {$IfEnd defined(AppServerSide)}
 ddServerTask
 ;


{ TalcuMdpImportDocs }

class function TalcuMdpImportDocs.CanAsyncRun: Boolean;
begin
 Result := True;
end;

function TalcuMdpImportDocs.CanSimultaneousRunWith(
  const aTask: TddProcessTask): Boolean;
begin
 Result := (aTask = Self) or (ClassName <> aTask.ClassName);
end;

procedure TalcuMdpImportDocs.DoAbort;
begin
  inherited DoAbort;
{$IFDEF MDPSyncIntegrated}
  if Assigned(f_Syncronizer) then
   f_Syncronizer.AbortImport;
{$ENDIF MDPSyncIntegrated}
end;

procedure TalcuMdpImportDocs.DoRun(const aContext: TddRunContext);
begin
 inherited;
{$IFDEF MDPSyncIntegrated}
{$If defined(AppServerSide)}
 Error(Format('Задача %s должна работать в асинхронном режиме.', [Description]));
 Exit;
{$Else defined(AppServerSide)}
 f_Syncronizer := TalcuMDPSyncronizer.Create;
 try
  f_Syncronizer.Execute({$IFDEF Region} False {$ELSE Region} True {$ENDIF Region}, aContext.rProgressor, MaxCount, Mail, ErrorMail);
 finally
  FreeAndNil(f_Syncronizer);
 end;
{$IfEnd defined(AppServerSide)}
{$ENDIF MDPSyncIntegrated}
end;

function TalcuMdpImportDocs.IgnoreStrangeExitCode: Boolean;
begin
 Result := True;
end;

function TalcuMdpImportDocs.IsHiddenFromUser: Boolean;
begin
 Result := True;
end;

{$If defined(AppServerSide)}
procedure TalcuMdpImportDocs.SetupServerSideConfigParams;
begin
 inherited;
 MaxCount := ddAppConfiguration.AsInteger['mdpMaxCount'];
 Mail := ddAppConfiguration.AsString['mdpMail'];
 ErrorMail := ddAppConfiguration.AsString['mdpErrorMail'];
end;
{$IfEnd defined(AppServerSide)}

initialization
 RegisterTaskClass(cs_ttMdpImportDocs, TalcuMdpImportDocs, 'Импорт документов из Гардока');

end.

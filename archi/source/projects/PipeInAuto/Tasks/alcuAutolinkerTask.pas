unit alcuAutolinkerTask;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 ddProcessTaskPrim,

 csProcessTask,
 csAutolinkerTask,

 ddAutolinker
 ;

type
 TalcuAutolinkerTask = class(TcsAutolinkerTask)
 private
  f_Linker: TddAutolinker;
 protected
  procedure DoAbort; override;
  procedure DoRun(const aContext: TddRunContext); override;
  {$If defined(AppServerSide)}
  procedure DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
 public
  class function CanAsyncRun: Boolean; override;
 end;

implementation

uses
 SysUtils,

 csTaskTypes,

 daSchemeConsts,

 dtIntf,
 dt_Sab,
 dt_Doc,

 l3FileUtils,

 ddServerTask
 ;

{ TalcuAutolinkerTask }

class function TalcuAutolinkerTask.CanAsyncRun: Boolean;
begin
 Result := True;
end;

procedure TalcuAutolinkerTask.DoAbort;
begin
 inherited;
 if Assigned(f_Linker) then
  f_Linker.AbortProcess;
end;

procedure TalcuAutolinkerTask.DoRun(const aContext: TddRunContext);
var
 l_Sab: ISab;
begin
 l_Sab := MakeValueSet(DocumentServer(CurrentFamily).FileTbl, fID_Fld, DocumentIDList);
 try
  f_Linker := GetAutoLinker;
  try
   f_Linker.SetLinks(l_Sab, aContext.rProgressor, ClearLinksBeforeRun);
  finally
   f_Linker := nil;
  end;
 finally
  l_Sab := nil;
 end;
end;

{$If defined(AppServerSide)}
procedure TalcuAutolinkerTask.DoRunSuccessfullyFinished(
  const aServices: IcsRunTaskServices);
begin
  inherited;
end;
{$IfEnd defined(AppServerSide)}

initialization
 RegisterTaskClass(cs_ttAutolinker, TalcuAutolinkerTask, 'јвтоматическа€ простановка гиперссылок');

end.
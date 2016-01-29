unit alcuAutoSpell;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 ddProcessTaskPrim,

 csProcessTask,
 csAutoSpell,
 csTaskResult,

 alcuAutoSpellTaskResult,
 alcuSpellChecker
 ;

type
 TalcuAutoSpellTask = class(TcsAutoSpellTask)
 private
  f_Checker: TalcuSpellChecker;
  function pm_GetTaskResult: TalcuAutoSpellTaskResult;
 protected
  function pm_GetTaskFolder: AnsiString; override;
  function GetTaskResultClass: TcsTaskResultClass; override;
  procedure DoAbort; override;
  procedure DoRun(const aContext: TddRunContext); override;
  {$If defined(AppServerSide)}
  procedure DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
 public
  class function CanAsyncRun: Boolean; override;
  property TaskResult: TalcuAutoSpellTaskResult read pm_GetTaskResult;
 end;

implementation

uses
 SysUtils,

 l3FileUtils,

 ddServerTask,
{$If defined(AppServerSide)}
 ddAppConfig,
{$IfEnd defined(AppServerSide)}

 csTaskTypes,
 Task_Const,

 m3StorageElementIDList

{$If defined(AppServerSide)}
 , alcuMailServer
{$IfEnd defined(AppServerSide)}
 ;

{ TalcuAutoSpellTask }

class function TalcuAutoSpellTask.CanAsyncRun: Boolean;
begin
 Result := True;
end;

procedure TalcuAutoSpellTask.DoAbort;
begin
  inherited;
  if Assigned(f_Checker) then
    f_Checker.AbortProcess;
end;

procedure TalcuAutoSpellTask.DoRun(const aContext: TddRunContext);
var
 l_List : Tm3StorageElementIDList;
 l_Index : Integer;
begin
 ForceDirectories(TaskFolder);
 f_Checker := TalcuSpellChecker.Create;
 try
  with f_Checker do
  begin
   l_List:= Tm3StorageElementIDList.Create;
   try
    l_List.Clear;
    for l_Index := 0 to Pred(DocumentIDList.Count) do
     l_List.Add(DocumentIDList.Items[l_Index]);
    Execute(l_List, aContext.rProgressor);
    if ErrorsList.Count > 0 then
    begin
     TaskResult.ReportAttach := ConcatDirName(TaskFolder,'misspells.txt');
     ErrorsList.SaveToFile(TaskResult.ReportAttach);
     TaskResult.ReportMessage := 'Список найденных ошибок в файле misspells.txt';
    end
    else
    begin
     TaskResult.ReportMessage := 'В полученном списке документов ошибок не найдено';
    end;
   finally
    FreeAndNil(l_List);
   end;
  end;
 finally
  FreeAndNil(f_Checker);
 end;
end;

{$If defined(AppServerSide)}
procedure TalcuAutoSpellTask.DoRunSuccessfullyFinished(
  const aServices: IcsRunTaskServices);
begin
  inherited;
  alcuMail.SendEmail(ddAppConfiguration.AsString['asNotify'], TaskResult.ReportMessage, 'Автоматическая проверка орфографии',
    TaskResult.ReportAttach);
  PureDir(TaskFolder);
  DelDir(TaskFolder);
end;
{$IfEnd defined(AppServerSide)}

function TalcuAutoSpellTask.GetTaskResultClass: TcsTaskResultClass;
begin
 Result := TalcuAutoSpellTaskResult;
end;

function TalcuAutoSpellTask.pm_GetTaskFolder: AnsiString;
begin
 Result := ConcatDirName(TaggedData.StrA[k2_attrTaskFolder], 'SpellCheck\' + TaskID);
end;

function TalcuAutoSpellTask.pm_GetTaskResult: TalcuAutoSpellTaskResult;
begin
  Result := TalcuAutoSpellTaskResult(inherited TaskResult);
end;

initialization
 RegisterTaskClass(cs_ttAutoSpellCheck, TalcuAutoSpellTask, 'Автоматическая проверка орфографии');

end.
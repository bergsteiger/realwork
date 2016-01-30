unit K517772970_TalcuAutoExportTask;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuAutoExportTask.pas"
// Стереотип: "TestCase"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TddProcessTask
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TalcuAutoExportTask = class(TK517772970_TddProcessTask)
  {* [RequestLink:517772970] }
  protected
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
   function TaskClass: TddTaskClass; override;
   procedure InitTask(Task: TddTaskItem); override;
 end;//TK517772970_TalcuAutoExportTask
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(ServerTasks)}
 , alcuAutoExportTask
 {$IfEnd} // Defined(ServerTasks)
 , evdDTTypes
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TalcuAutoExportTask.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TalcuAutoExportTask.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TalcuAutoExportTask.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53214FDB01D3';
end;//TK517772970_TalcuAutoExportTask.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TalcuAutoExportTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53214FDB01D3_var*
//#UC END# *5320088202FB_53214FDB01D3_var*
begin
//#UC START# *5320088202FB_53214FDB01D3_impl*
 Result := TalcuAutoExportTask;
//#UC END# *5320088202FB_53214FDB01D3_impl*
end;//TK517772970_TalcuAutoExportTask.TaskClass

procedure TK517772970_TalcuAutoExportTask.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53214FDB01D3_var*
//#UC END# *532008D203BA_53214FDB01D3_var*
begin
//#UC START# *532008D203BA_53214FDB01D3_impl*
 inherited;
 (Task As TalcuAutoExportTask).Stages := [aeAnnotations, aeChanged];
//#UC END# *532008D203BA_53214FDB01D3_impl*
end;//TK517772970_TalcuAutoExportTask.InitTask

initialization
 TestFramework.RegisterTest(TK517772970_TalcuAutoExportTask.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.

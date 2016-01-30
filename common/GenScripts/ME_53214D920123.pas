unit K517772970_TalcuRegionAutoExportTask;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuRegionAutoExportTask.pas"
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
 TK517772970_TalcuRegionAutoExportTask = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TalcuRegionAutoExportTask
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(ServerTasks)}
 , alcuRegionAutoExportTask
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TalcuRegionAutoExportTask.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TalcuRegionAutoExportTask.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TalcuRegionAutoExportTask.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53214D920123';
end;//TK517772970_TalcuRegionAutoExportTask.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TalcuRegionAutoExportTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53214D920123_var*
//#UC END# *5320088202FB_53214D920123_var*
begin
//#UC START# *5320088202FB_53214D920123_impl*
 result := TalcuRegionAutoExportTask;
//#UC END# *5320088202FB_53214D920123_impl*
end;//TK517772970_TalcuRegionAutoExportTask.TaskClass

procedure TK517772970_TalcuRegionAutoExportTask.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53214D920123_var*
const
 IntConst = 2;
//#UC END# *532008D203BA_53214D920123_var*
begin
//#UC START# *532008D203BA_53214D920123_impl*
 inherited InitTask(Task);
 (Task as TalcuRegionAutoExportTask).RegionIndex := IntConst;
//#UC END# *532008D203BA_53214D920123_impl*
end;//TK517772970_TalcuRegionAutoExportTask.InitTask

initialization
 TestFramework.RegisterTest(TK517772970_TalcuRegionAutoExportTask.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.

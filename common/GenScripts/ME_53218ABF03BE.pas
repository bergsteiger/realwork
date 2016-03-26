unit K517772970_TalcuRelPublishTask;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuRelPublishTask.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TalcuRelPublishTask" MUID: (53218ABF03BE)
// Имя типа: "TK517772970_TalcuRelPublishTask"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TcsImportTaskItem
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TalcuRelPublishTask = class(TK517772970_TcsImportTaskItem)
  {* [RequestLink:517772970] }
  protected
   function TaskClass: TddTaskClass; override;
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
 end;//TK517772970_TalcuRelPublishTask
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(ServerTasks)}
 , alcuRelCorrector
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

function TK517772970_TalcuRelPublishTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53218ABF03BE_var*
//#UC END# *5320088202FB_53218ABF03BE_var*
begin
//#UC START# *5320088202FB_53218ABF03BE_impl*
 result := TalcuRelPublishTask;
//#UC END# *5320088202FB_53218ABF03BE_impl*
end;//TK517772970_TalcuRelPublishTask.TaskClass

{$If Defined(nsTest)}
function TK517772970_TalcuRelPublishTask.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TalcuRelPublishTask.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TalcuRelPublishTask.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53218ABF03BE';
end;//TK517772970_TalcuRelPublishTask.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TalcuRelPublishTask.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.

unit K517772970_TalcuHavanskyExportTask;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuHavanskyExportTask.pas"
// Стереотип: "TestCase"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TalcuExport
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TalcuHavanskyExportTask = class(TK517772970_TalcuExport)
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
 end;//TK517772970_TalcuHavanskyExportTask
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(ServerTasks)}
 , alcuHavanskyExportTask
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TalcuHavanskyExportTask.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TalcuHavanskyExportTask.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TalcuHavanskyExportTask.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5321847300AB';
end;//TK517772970_TalcuHavanskyExportTask.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TalcuHavanskyExportTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_5321847300AB_var*
//#UC END# *5320088202FB_5321847300AB_var*
begin
//#UC START# *5320088202FB_5321847300AB_impl*
 result := TalcuHavanskyExportTask;
//#UC END# *5320088202FB_5321847300AB_impl*
end;//TK517772970_TalcuHavanskyExportTask.TaskClass

initialization
 TestFramework.RegisterTest(TK517772970_TalcuHavanskyExportTask.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.

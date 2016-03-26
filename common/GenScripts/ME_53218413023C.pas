unit K517772970_TalcuAnoncedExport;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuAnoncedExport.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TalcuAnoncedExport" MUID: (53218413023C)
// Имя типа: "TK517772970_TalcuAnoncedExport"

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
 TK517772970_TalcuAnoncedExport = class(TK517772970_TalcuExport)
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
 end;//TK517772970_TalcuAnoncedExport
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(ServerTasks)}
 , alcuAnoncedExport
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

function TK517772970_TalcuAnoncedExport.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53218413023C_var*
//#UC END# *5320088202FB_53218413023C_var*
begin
//#UC START# *5320088202FB_53218413023C_impl*
 result := TalcuAnoncedExport;
//#UC END# *5320088202FB_53218413023C_impl*
end;//TK517772970_TalcuAnoncedExport.TaskClass

{$If Defined(nsTest)}
function TK517772970_TalcuAnoncedExport.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TalcuAnoncedExport.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TalcuAnoncedExport.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53218413023C';
end;//TK517772970_TalcuAnoncedExport.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TalcuAnoncedExport.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.

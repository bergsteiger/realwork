unit K517772970_TalcuAutoSpellTask;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuAutoSpellTask.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TalcuAutoSpellTask" MUID: (53214DE40178)
// Имя типа: "TK517772970_TalcuAutoSpellTask"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

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
 TK517772970_TalcuAutoSpellTask = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TalcuAutoSpellTask
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(ServerTasks)}
 , alcuAutoSpell
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 //#UC START# *53214DE40178impl_uses*
 //#UC END# *53214DE40178impl_uses*
;

function TK517772970_TalcuAutoSpellTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53214DE40178_var*
//#UC END# *5320088202FB_53214DE40178_var*
begin
//#UC START# *5320088202FB_53214DE40178_impl*
 result := TalcuAutoSpellTask;
//#UC END# *5320088202FB_53214DE40178_impl*
end;//TK517772970_TalcuAutoSpellTask.TaskClass

{$If Defined(nsTest)}
function TK517772970_TalcuAutoSpellTask.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TalcuAutoSpellTask.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TalcuAutoSpellTask.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53214DE40178';
end;//TK517772970_TalcuAutoSpellTask.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TalcuAutoSpellTask.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.

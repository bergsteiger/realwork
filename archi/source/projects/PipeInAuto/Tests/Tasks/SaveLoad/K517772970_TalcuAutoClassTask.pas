unit K517772970_TalcuAutoClassTask;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuAutoClassTask.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TalcuAutoClassTask" MUID: (53214B3E02D3)
// Имя типа: "TK517772970_TalcuAutoClassTask"

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
 TK517772970_TalcuAutoClassTask = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TalcuAutoClassTask
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(ServerTasks)}
 , alcuAutoClassifier
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 //#UC START# *53214B3E02D3impl_uses*
 //#UC END# *53214B3E02D3impl_uses*
;

function TK517772970_TalcuAutoClassTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53214B3E02D3_var*
//#UC END# *5320088202FB_53214B3E02D3_var*
begin
//#UC START# *5320088202FB_53214B3E02D3_impl*
 result := TalcuAutoClassTask;
//#UC END# *5320088202FB_53214B3E02D3_impl*
end;//TK517772970_TalcuAutoClassTask.TaskClass

{$If Defined(nsTest)}
function TK517772970_TalcuAutoClassTask.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TalcuAutoClassTask.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TalcuAutoClassTask.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53214B3E02D3';
end;//TK517772970_TalcuAutoClassTask.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TalcuAutoClassTask.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.

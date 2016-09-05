unit K517772970_TddGetTaskRequest;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddGetTaskRequest.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TddGetTaskRequest" MUID: (532140360355)
// Имя типа: "TK517772970_TddGetTaskRequest"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TaskRequest
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TddGetTaskRequest = class(TK517772970_TaskRequest)
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
 end;//TK517772970_TddGetTaskRequest
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csTaskRequest
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 //#UC START# *532140360355impl_uses*
 //#UC END# *532140360355impl_uses*
;

function TK517772970_TddGetTaskRequest.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_532140360355_var*
//#UC END# *5320088202FB_532140360355_var*
begin
//#UC START# *5320088202FB_532140360355_impl*
 result := TddGetTaskRequest;
//#UC END# *5320088202FB_532140360355_impl*
end;//TK517772970_TddGetTaskRequest.TaskClass

{$If Defined(nsTest)}
function TK517772970_TddGetTaskRequest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddGetTaskRequest.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TddGetTaskRequest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '532140360355';
end;//TK517772970_TddGetTaskRequest.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TddGetTaskRequest.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.

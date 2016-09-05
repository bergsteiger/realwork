unit K517772970_TddTaskResultRequest;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddTaskResultRequest.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TddTaskResultRequest" MUID: (532140140146)
// Имя типа: "TK517772970_TddTaskResultRequest"

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
 TK517772970_TddTaskResultRequest = class(TK517772970_TaskRequest)
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
 end;//TK517772970_TddTaskResultRequest
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
 //#UC START# *532140140146impl_uses*
 //#UC END# *532140140146impl_uses*
;

function TK517772970_TddTaskResultRequest.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_532140140146_var*
//#UC END# *5320088202FB_532140140146_var*
begin
//#UC START# *5320088202FB_532140140146_impl*
 result := TddTaskResultRequest;
//#UC END# *5320088202FB_532140140146_impl*
end;//TK517772970_TddTaskResultRequest.TaskClass

{$If Defined(nsTest)}
function TK517772970_TddTaskResultRequest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddTaskResultRequest.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TddTaskResultRequest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '532140140146';
end;//TK517772970_TddTaskResultRequest.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TddTaskResultRequest.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.

unit K517772970_TddCommonDataRequest;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddCommonDataRequest.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TddCommonDataRequest" MUID: (5320228E011B)
// Имя типа: "TK517772970_TddCommonDataRequest"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TddRequestTask
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TddCommonDataRequest = class(TK517772970_TddRequestTask)
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
 end;//TK517772970_TddCommonDataRequest
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csCommonDataRequest
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

function TK517772970_TddCommonDataRequest.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_5320228E011B_var*
//#UC END# *5320088202FB_5320228E011B_var*
begin
//#UC START# *5320088202FB_5320228E011B_impl*
 result := TddCommonDataRequest;
//#UC END# *5320088202FB_5320228E011B_impl*
end;//TK517772970_TddCommonDataRequest.TaskClass

{$If Defined(nsTest)}
function TK517772970_TddCommonDataRequest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddCommonDataRequest.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TddCommonDataRequest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5320228E011B';
end;//TK517772970_TddCommonDataRequest.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TddCommonDataRequest.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.

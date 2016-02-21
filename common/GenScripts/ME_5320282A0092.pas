unit K517772970_TddNonEditableDictsRequest;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddNonEditableDictsRequest.pas"
// Стереотип: "TestCase"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)}
uses
 l3IntfUses
 , K517772970_TddRequestTask
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TddNonEditableDictsRequest = class(TK517772970_TddRequestTask)
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
 end;//TK517772970_TddNonEditableDictsRequest
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csNonEditableDictsRequest
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TddNonEditableDictsRequest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddNonEditableDictsRequest.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TddNonEditableDictsRequest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5320282A0092';
end;//TK517772970_TddNonEditableDictsRequest.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TddNonEditableDictsRequest.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_5320282A0092_var*
//#UC END# *5320088202FB_5320282A0092_var*
begin
//#UC START# *5320088202FB_5320282A0092_impl*
 result := TddNonEditableDictsRequest;
//#UC END# *5320088202FB_5320282A0092_impl*
end;//TK517772970_TddNonEditableDictsRequest.TaskClass

initialization
 TestFramework.RegisterTest(TK517772970_TddNonEditableDictsRequest.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)

end.

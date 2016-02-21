unit K517772970_TddNonEditableDictsRequestDefault;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddNonEditableDictsRequestDefault.pas"
// Стереотип: "TestCase"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)}
uses
 l3IntfUses
 , K517772970_TCheckSaveToStreamDefault
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TddNonEditableDictsRequestDefault = class(TK517772970_TCheckSaveToStreamDefault)
  {* [RequestLink:517772970] }
  protected
   function GetTaskClass: TddTaskClass; override;
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
 end;//TK517772970_TddNonEditableDictsRequestDefault
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
 , l3Filer
 , SysUtils
;

function TK517772970_TddNonEditableDictsRequestDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_53197A9A0212_var*
//#UC END# *53170E4100CF_53197A9A0212_var*
begin
//#UC START# *53170E4100CF_53197A9A0212_impl*
 result := TddNonEditableDictsRequest;
//#UC END# *53170E4100CF_53197A9A0212_impl*
end;//TK517772970_TddNonEditableDictsRequestDefault.GetTaskClass

{$If Defined(nsTest)}
function TK517772970_TddNonEditableDictsRequestDefault.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TddNonEditableDictsRequestDefault.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TddNonEditableDictsRequestDefault.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53197A9A0212';
end;//TK517772970_TddNonEditableDictsRequestDefault.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TddNonEditableDictsRequestDefault.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)

end.

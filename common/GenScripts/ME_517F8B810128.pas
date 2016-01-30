unit K453149163;
 {* [Requestlink:453149163] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K453149163.pas"
// Стереотип: "TestCase"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK453149163 = class(TArchiInsiderTest)
  {* [Requestlink:453149163] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK453149163
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK453149163.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableBoundariesAlignment';
end;//TK453149163.GetFolder

function TK453149163.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '517F8B810128';
end;//TK453149163.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK453149163.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

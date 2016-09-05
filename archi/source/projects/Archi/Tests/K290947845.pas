unit K290947845;
 {* [Requestlink:290947845] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K290947845.pas"
// Стереотип: "TestCase"
// Элемент модели: "K290947845" MUID: (4E8EDEE500A6)
// Имя типа: "TK290947845"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK290947845 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:290947845] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK290947845
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4E8EDEE500A6impl_uses*
 //#UC END# *4E8EDEE500A6impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK290947845.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK290947845.GetFolder

function TK290947845.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E8EDEE500A6';
end;//TK290947845.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK290947845.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

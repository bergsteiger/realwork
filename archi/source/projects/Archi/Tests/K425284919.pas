unit K425284919;
 {* [Requestlink:425284919] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K425284919.pas"
// Стереотип: "TestCase"
// Элемент модели: "K425284919" MUID: (5163ED700399)
// Имя типа: "TK425284919"

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
 TK425284919 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:425284919] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK425284919
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5163ED700399impl_uses*
 //#UC END# *5163ED700399impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK425284919.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK425284919.GetFolder

function TK425284919.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5163ED700399';
end;//TK425284919.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK425284919.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

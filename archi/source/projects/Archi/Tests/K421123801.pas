unit K421123801;
 {* [Requestlink:421123801] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K421123801.pas"
// Стереотип: "TestCase"
// Элемент модели: "K421123801" MUID: (50D961520067)
// Имя типа: "TK421123801"

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
 TK421123801 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:421123801] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK421123801
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *50D961520067impl_uses*
 //#UC END# *50D961520067impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK421123801.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScrollTests';
end;//TK421123801.GetFolder

function TK421123801.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50D961520067';
end;//TK421123801.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK421123801.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

unit K342862858;
 {* [Requestlink:342862858] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K342862858.pas"
// Стереотип: "TestCase"
// Элемент модели: "K342862858" MUID: (4F50C48F01E0)
// Имя типа: "TK342862858"

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
 TK342862858 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:342862858] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK342862858
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F50C48F01E0impl_uses*
 //#UC END# *4F50C48F01E0impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK342862858.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK342862858.GetFolder

function TK342862858.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F50C48F01E0';
end;//TK342862858.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK342862858.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

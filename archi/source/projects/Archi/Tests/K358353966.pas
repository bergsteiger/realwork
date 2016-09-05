unit K358353966;
 {* [Requestlink:358353966] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K358353966.pas"
// Стереотип: "TestCase"
// Элемент модели: "K358353966" MUID: (4FB4A0000314)
// Имя типа: "TK358353966"

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
 TK358353966 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:358353966] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK358353966
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4FB4A0000314impl_uses*
 //#UC END# *4FB4A0000314impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK358353966.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK358353966.GetFolder

function TK358353966.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FB4A0000314';
end;//TK358353966.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358353966.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

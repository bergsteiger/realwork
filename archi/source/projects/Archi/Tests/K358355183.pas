unit K358355183;
 {* [Requestlink:358355183] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K358355183.pas"
// Стереотип: "TestCase"
// Элемент модели: "K358355183" MUID: (4F880641026F)
// Имя типа: "TK358355183"

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
 TK358355183 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:358355183] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK358355183
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F880641026Fimpl_uses*
 //#UC END# *4F880641026Fimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK358355183.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK358355183.GetFolder

function TK358355183.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F880641026F';
end;//TK358355183.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358355183.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

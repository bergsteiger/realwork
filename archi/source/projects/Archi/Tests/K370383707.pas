unit K370383707;
 {* [Requestlink:370383707] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K370383707.pas"
// Стереотип: "TestCase"
// Элемент модели: "K370383707" MUID: (4FCE1487026F)
// Имя типа: "TK370383707"

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
 TK370383707 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:370383707] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK370383707
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4FCE1487026Fimpl_uses*
 //#UC END# *4FCE1487026Fimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK370383707.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK370383707.GetFolder

function TK370383707.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FCE1487026F';
end;//TK370383707.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK370383707.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

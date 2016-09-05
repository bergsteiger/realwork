unit K400531159;
 {* [Requestlink:400531159] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K400531159.pas"
// Стереотип: "TestCase"
// Элемент модели: "K400531159" MUID: (50750748009E)
// Имя типа: "TK400531159"

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
 TK400531159 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:400531159] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK400531159
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *50750748009Eimpl_uses*
 //#UC END# *50750748009Eimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK400531159.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK400531159.GetFolder

function TK400531159.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50750748009E';
end;//TK400531159.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK400531159.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

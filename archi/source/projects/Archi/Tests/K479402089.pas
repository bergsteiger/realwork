unit K479402089;
 {* [Requestlink:479402089] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K479402089.pas"
// Стереотип: "TestCase"
// Элемент модели: "K479402089" MUID: (521712E10090)
// Имя типа: "TK479402089"

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
 TK479402089 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:479402089] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK479402089
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *521712E10090impl_uses*
 //#UC END# *521712E10090impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK479402089.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK479402089.GetFolder

function TK479402089.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '521712E10090';
end;//TK479402089.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK479402089.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

unit K437519085;
 {* [Requestlink:437519085] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K437519085.pas"
// Стереотип: "TestCase"
// Элемент модели: "K437519085" MUID: (5153EAB202A2)
// Имя типа: "TK437519085"

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
 TK437519085 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:437519085] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK437519085
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5153EAB202A2impl_uses*
 //#UC END# *5153EAB202A2impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK437519085.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableBoundariesAlignment';
end;//TK437519085.GetFolder

function TK437519085.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5153EAB202A2';
end;//TK437519085.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK437519085.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

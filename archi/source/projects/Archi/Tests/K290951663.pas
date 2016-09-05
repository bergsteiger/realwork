unit K290951663;
 {* [Requestlink:290951663] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K290951663.pas"
// Стереотип: "TestCase"
// Элемент модели: "K290951663" MUID: (4ECCEB2A01A9)
// Имя типа: "TK290951663"

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
 TK290951663 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:290951663] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK290951663
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4ECCEB2A01A9impl_uses*
 //#UC END# *4ECCEB2A01A9impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK290951663.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK290951663.GetFolder

function TK290951663.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4ECCEB2A01A9';
end;//TK290951663.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK290951663.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

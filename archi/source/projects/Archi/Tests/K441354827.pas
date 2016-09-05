unit K441354827;
 {* [Requestlink:441354827] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K441354827.pas"
// Стереотип: "TestCase"
// Элемент модели: "K441354827" MUID: (5217342400A7)
// Имя типа: "TK441354827"

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
 TK441354827 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:441354827] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK441354827
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5217342400A7impl_uses*
 //#UC END# *5217342400A7impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK441354827.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK441354827.GetFolder

function TK441354827.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5217342400A7';
end;//TK441354827.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK441354827.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

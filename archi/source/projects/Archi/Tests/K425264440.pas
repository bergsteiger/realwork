unit K425264440;
 {* [Requestlink:425264440] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K425264440.pas"
// Стереотип: "TestCase"
// Элемент модели: "K425264440" MUID: (5108C83C00DE)
// Имя типа: "TK425264440"

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
 TK425264440 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:425264440] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK425264440
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5108C83C00DEimpl_uses*
 //#UC END# *5108C83C00DEimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK425264440.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SelectionTests';
end;//TK425264440.GetFolder

function TK425264440.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5108C83C00DE';
end;//TK425264440.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK425264440.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

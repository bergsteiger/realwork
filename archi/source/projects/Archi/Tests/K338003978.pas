unit K338003978;
 {* [Requestlink:338003978] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K338003978.pas"
// Стереотип: "TestCase"
// Элемент модели: "K338003978" MUID: (5199FE8E0249)
// Имя типа: "TK338003978"

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
 TK338003978 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:338003978] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK338003978
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5199FE8E0249impl_uses*
 //#UC END# *5199FE8E0249impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK338003978.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK338003978.GetFolder

function TK338003978.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5199FE8E0249';
end;//TK338003978.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK338003978.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

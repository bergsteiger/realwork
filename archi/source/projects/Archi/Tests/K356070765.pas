unit K356070765;
 {* [Requestlink:356070765] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K356070765.pas"
// Стереотип: "TestCase"
// Элемент модели: "TK356070765" MUID: (4F8D2DE8000F)

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
 TK356070765 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:356070765] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK356070765
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F8D2DE8000Fimpl_uses*
 //#UC END# *4F8D2DE8000Fimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK356070765.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DialogTest';
end;//TK356070765.GetFolder

function TK356070765.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F8D2DE8000F';
end;//TK356070765.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK356070765.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

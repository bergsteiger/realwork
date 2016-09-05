unit K377749722;
 {* [Requestlink:377749722] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K377749722.pas"
// Стереотип: "TestCase"
// Элемент модели: "K377749722" MUID: (5170F84503CB)
// Имя типа: "TK377749722"

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
 TK377749722 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:377749722] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK377749722
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5170F84503CBimpl_uses*
 //#UC END# *5170F84503CBimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK377749722.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'OEMTextTests';
end;//TK377749722.GetFolder

function TK377749722.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5170F84503CB';
end;//TK377749722.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK377749722.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

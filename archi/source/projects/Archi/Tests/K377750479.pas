unit K377750479;
 {* [Requestlink:377750479] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K377750479.pas"
// Стереотип: "TestCase"
// Элемент модели: "K377750479" MUID: (516BB93402B5)
// Имя типа: "TK377750479"

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
 TK377750479 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:377750479] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK377750479
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *516BB93402B5impl_uses*
 //#UC END# *516BB93402B5impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK377750479.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK377750479.GetFolder

function TK377750479.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '516BB93402B5';
end;//TK377750479.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK377750479.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

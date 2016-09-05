unit K331186226;
 {* [RequestLink:331186226] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K331186226.pas"
// Стереотип: "TestCase"
// Элемент модели: "K331186226" MUID: (4F28D3300037)
// Имя типа: "TK331186226"

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
 TK331186226 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [RequestLink:331186226] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK331186226
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F28D3300037impl_uses*
 //#UC END# *4F28D3300037impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK331186226.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ContentsTree';
end;//TK331186226.GetFolder

function TK331186226.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F28D3300037';
end;//TK331186226.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK331186226.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

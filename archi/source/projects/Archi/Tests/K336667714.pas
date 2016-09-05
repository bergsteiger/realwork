unit K336667714;
 {* [Requestlink:336667714] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K336667714.pas"
// Стереотип: "TestCase"
// Элемент модели: "K336667714" MUID: (4F98FB940182)
// Имя типа: "TK336667714"

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
 TK336667714 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:336667714] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK336667714
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F98FB940182impl_uses*
 //#UC END# *4F98FB940182impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK336667714.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK336667714.GetFolder

function TK336667714.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F98FB940182';
end;//TK336667714.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336667714.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

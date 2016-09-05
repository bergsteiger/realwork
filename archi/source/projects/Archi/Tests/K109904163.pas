unit K109904163;
 {* [Requestlink:109904163] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K109904163.pas"
// Стереотип: "TestCase"
// Элемент модели: "K109904163" MUID: (4ED76BDA0286)
// Имя типа: "TK109904163"

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
 TK109904163 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:109904163] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK109904163
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4ED76BDA0286impl_uses*
 //#UC END# *4ED76BDA0286impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK109904163.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SBSTests';
end;//TK109904163.GetFolder

function TK109904163.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4ED76BDA0286';
end;//TK109904163.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK109904163.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

unit K423593340;
 {* [Requestlink:423593340] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K423593340.pas"
// Стереотип: "TestCase"
// Элемент модели: "K423593340" MUID: (50EFBD870384)
// Имя типа: "TK423593340"

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
 TK423593340 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:423593340] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK423593340
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *50EFBD870384impl_uses*
 //#UC END# *50EFBD870384impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK423593340.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScrollTests';
end;//TK423593340.GetFolder

function TK423593340.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50EFBD870384';
end;//TK423593340.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK423593340.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

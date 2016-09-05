unit K425273666;
 {* [Requestlink:425273666] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K425273666.pas"
// Стереотип: "TestCase"
// Элемент модели: "K425273666" MUID: (510904840242)
// Имя типа: "TK425273666"

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
 TK425273666 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:425273666] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK425273666
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *510904840242impl_uses*
 //#UC END# *510904840242impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK425273666.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SelectionTests';
end;//TK425273666.GetFolder

function TK425273666.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '510904840242';
end;//TK425273666.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK425273666.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

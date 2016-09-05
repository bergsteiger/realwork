unit K480809940;
 {* [Requestlink:480809940] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K480809940.pas"
// Стереотип: "TestCase"
// Элемент модели: "K480809940" MUID: (521EFB1200C3)
// Имя типа: "TK480809940"

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
 TK480809940 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:480809940] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK480809940
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *521EFB1200C3impl_uses*
 //#UC END# *521EFB1200C3impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK480809940.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DialogTest';
end;//TK480809940.GetFolder

function TK480809940.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '521EFB1200C3';
end;//TK480809940.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK480809940.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

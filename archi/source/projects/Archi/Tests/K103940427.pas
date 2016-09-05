unit K103940427;
 {* [Requestlink:103940427] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K103940427.pas"
// Стереотип: "TestCase"
// Элемент модели: "K103940427" MUID: (4FAE53CA00EE)
// Имя типа: "TK103940427"

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
 TK103940427 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:103940427] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK103940427
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4FAE53CA00EEimpl_uses*
 //#UC END# *4FAE53CA00EEimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK103940427.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Text2TableTests';
end;//TK103940427.GetFolder

function TK103940427.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FAE53CA00EE';
end;//TK103940427.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK103940427.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

unit K370384889;
 {* [Requestlink:370384889] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K370384889.pas"
// Стереотип: "TestCase"
// Элемент модели: "K370384889" MUID: (4FCF0C2800FE)
// Имя типа: "TK370384889"

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
 TK370384889 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:370384889] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK370384889
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4FCF0C2800FEimpl_uses*
 //#UC END# *4FCF0C2800FEimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK370384889.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'OEMTextTests';
end;//TK370384889.GetFolder

function TK370384889.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FCF0C2800FE';
end;//TK370384889.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK370384889.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

unit K382406560;
 {* [Requestlink:382406560] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K382406560.pas"
// Стереотип: "TestCase"
// Элемент модели: "K382406560" MUID: (51A489C8039F)
// Имя типа: "TK382406560"

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
 TK382406560 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:382406560] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK382406560
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *51A489C8039Fimpl_uses*
 //#UC END# *51A489C8039Fimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK382406560.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SelectionTests';
end;//TK382406560.GetFolder

function TK382406560.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51A489C8039F';
end;//TK382406560.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK382406560.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

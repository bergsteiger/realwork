unit K479402808;
 {* [Requestlink:479402808] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K479402808.pas"
// Стереотип: "TestCase"
// Элемент модели: "K479402808" MUID: (521C74DD03CD)
// Имя типа: "TK479402808"

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
 TK479402808 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:479402808] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK479402808
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *521C74DD03CDimpl_uses*
 //#UC END# *521C74DD03CDimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK479402808.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK479402808.GetFolder

function TK479402808.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '521C74DD03CD';
end;//TK479402808.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK479402808.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

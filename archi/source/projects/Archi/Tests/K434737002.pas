unit K434737002;
 {* [Requestlink:434737002] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K434737002.pas"
// Стереотип: "TestCase"
// Элемент модели: "K434737002" MUID: (5135C19D008F)
// Имя типа: "TK434737002"

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
 TK434737002 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:434737002] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK434737002
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5135C19D008Fimpl_uses*
 //#UC END# *5135C19D008Fimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK434737002.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DialogTest';
end;//TK434737002.GetFolder

function TK434737002.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5135C19D008F';
end;//TK434737002.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK434737002.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

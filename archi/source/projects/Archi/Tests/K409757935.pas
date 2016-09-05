unit K409757935;
 {* [Requestlink:409757935] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K409757935.pas"
// Стереотип: "TestCase"
// Элемент модели: "K409757935" MUID: (50ADF800026C)
// Имя типа: "TK409757935"

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
 TK409757935 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:409757935] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK409757935
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *50ADF800026Cimpl_uses*
 //#UC END# *50ADF800026Cimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK409757935.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Text2TableTests';
end;//TK409757935.GetFolder

function TK409757935.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50ADF800026C';
end;//TK409757935.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK409757935.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

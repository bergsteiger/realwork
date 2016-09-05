unit K342866806;
 {* [Requestlink:342866806] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K342866806.pas"
// Стереотип: "TestCase"
// Элемент модели: "K342866806" MUID: (4F55F2BD029C)
// Имя типа: "TK342866806"

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
 TK342866806 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:342866806] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK342866806
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F55F2BD029Cimpl_uses*
 //#UC END# *4F55F2BD029Cimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK342866806.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScrollTests';
end;//TK342866806.GetFolder

function TK342866806.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F55F2BD029C';
end;//TK342866806.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK342866806.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

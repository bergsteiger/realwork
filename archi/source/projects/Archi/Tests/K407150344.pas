unit K407150344;
 {* [Requestlink:407150344] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K407150344.pas"
// Стереотип: "TestCase"
// Элемент модели: "K407150344" MUID: (509277C40387)
// Имя типа: "TK407150344"

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
 TK407150344 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:407150344] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK407150344
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *509277C40387impl_uses*
 //#UC END# *509277C40387impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK407150344.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK407150344.GetFolder

function TK407150344.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '509277C40387';
end;//TK407150344.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK407150344.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

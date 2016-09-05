unit K395659375;
 {* [Requestlink:395659375] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K395659375.pas"
// Стереотип: "TestCase"
// Элемент модели: "K395659375" MUID: (506BE91B0045)
// Имя типа: "TK395659375"

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
 TK395659375 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:395659375] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK395659375
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *506BE91B0045impl_uses*
 //#UC END# *506BE91B0045impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK395659375.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK395659375.GetFolder

function TK395659375.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '506BE91B0045';
end;//TK395659375.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK395659375.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

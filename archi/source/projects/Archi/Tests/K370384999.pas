unit K370384999;
 {* [Requestlink:370384999] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K370384999.pas"
// Стереотип: "TestCase"
// Элемент модели: "K370384999" MUID: (4FDAC1410288)
// Имя типа: "TK370384999"

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
 TK370384999 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:370384999] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK370384999
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4FDAC1410288impl_uses*
 //#UC END# *4FDAC1410288impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK370384999.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Text2TableTests';
end;//TK370384999.GetFolder

function TK370384999.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FDAC1410288';
end;//TK370384999.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK370384999.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

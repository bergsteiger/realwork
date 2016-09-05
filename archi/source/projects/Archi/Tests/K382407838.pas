unit K382407838;
 {* [Requestlink:382407838] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K382407838.pas"
// Стереотип: "TestCase"
// Элемент модели: "K382407838" MUID: (502A4778025B)
// Имя типа: "TK382407838"

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
 TK382407838 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:382407838] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK382407838
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *502A4778025Bimpl_uses*
 //#UC END# *502A4778025Bimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK382407838.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SelectionTests';
end;//TK382407838.GetFolder

function TK382407838.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '502A4778025B';
end;//TK382407838.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK382407838.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

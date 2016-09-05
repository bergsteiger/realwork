unit K439979342;
 {* [Requestlink:439979342] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K439979342.pas"
// Стереотип: "TestCase"
// Элемент модели: "K439979342" MUID: (514AE76300C0)
// Имя типа: "TK439979342"

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
 TK439979342 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:439979342] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK439979342
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *514AE76300C0impl_uses*
 //#UC END# *514AE76300C0impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK439979342.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK439979342.GetFolder

function TK439979342.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '514AE76300C0';
end;//TK439979342.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK439979342.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

unit K481449280;
 {* [Requestlink:481449280] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K481449280.pas"
// Стереотип: "TestCase"
// Элемент модели: "K481449280" MUID: (522976FB00A4)
// Имя типа: "TK481449280"

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
 TK481449280 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:481449280] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK481449280
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *522976FB00A4impl_uses*
 //#UC END# *522976FB00A4impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK481449280.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DialogTest';
end;//TK481449280.GetFolder

function TK481449280.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '522976FB00A4';
end;//TK481449280.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK481449280.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

unit K336137132;
 {* [Requestlink:336137132] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K336137132.pas"
// Стереотип: "TestCase"
// Элемент модели: "TK336137132" MUID: (4F30E48602B2)

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
 TK336137132 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:336137132] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK336137132
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F30E48602B2impl_uses*
 //#UC END# *4F30E48602B2impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK336137132.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK336137132.GetFolder

function TK336137132.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F30E48602B2';
end;//TK336137132.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336137132.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

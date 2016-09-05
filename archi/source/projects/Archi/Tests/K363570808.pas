unit K363570808;
 {* [Requestlink:363570808] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K363570808.pas"
// Стереотип: "TestCase"
// Элемент модели: "K363570808" MUID: (4FAE53EC029B)
// Имя типа: "TK363570808"

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
 TK363570808 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:363570808] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK363570808
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4FAE53EC029Bimpl_uses*
 //#UC END# *4FAE53EC029Bimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK363570808.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Text2TableTests';
end;//TK363570808.GetFolder

function TK363570808.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FAE53EC029B';
end;//TK363570808.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK363570808.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

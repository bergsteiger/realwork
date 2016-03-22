unit K379250166;
 {* [Requestlink:379250166] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K379250166.pas"
// Стереотип: "TestCase"
// Элемент модели: "K379250166" MUID: (5016351603C0)
// Имя типа: "TK379250166"

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
 TK379250166 = class(TArchiInsiderTest)
  {* [Requestlink:379250166] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK379250166
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK379250166.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK379250166.GetFolder

function TK379250166.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5016351603C0';
end;//TK379250166.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK379250166.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

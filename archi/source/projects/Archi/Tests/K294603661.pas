unit K294603661;
 {* [Requestlink:294603661] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K294603661.pas"
// Стереотип: "TestCase"
// Элемент модели: "K294603661" MUID: (4EF2F52902AC)
// Имя типа: "TK294603661"

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
 TK294603661 = class(TArchiInsiderTest)
  {* [Requestlink:294603661] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK294603661
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK294603661.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK294603661.GetFolder

function TK294603661.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EF2F52902AC';
end;//TK294603661.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK294603661.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

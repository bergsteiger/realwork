unit K401511110;
 {* [Requestlink:401511110] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K401511110.pas"
// Стереотип: "TestCase"
// Элемент модели: "K401511110" MUID: (50752B5C0192)
// Имя типа: "TK401511110"

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
 TK401511110 = class(TArchiInsiderTest)
  {* [Requestlink:401511110] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK401511110
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK401511110.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK401511110.GetFolder

function TK401511110.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50752B5C0192';
end;//TK401511110.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK401511110.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

unit K514874341;
 {* [Requestlink:514874341] }

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\Tests\K514874341.pas"
// Стереотип: "TestCase"

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK514874341 = class(TArchiInsiderTest)
  {* [Requestlink:514874341] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK514874341
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK514874341.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FileFormatTests';
end;//TK514874341.GetFolder

function TK514874341.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5322CC6101C8';
end;//TK514874341.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK514874341.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

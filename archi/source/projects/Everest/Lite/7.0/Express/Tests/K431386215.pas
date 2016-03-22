unit K431386215;
 {* [RequestLink:431386215] }

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\Tests\K431386215.pas"
// Стереотип: "TestCase"
// Элемент модели: "K431386215" MUID: (512DCAD901C3)
// Имя типа: "TK431386215"

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK431386215 = class(TArchiInsiderTest)
  {* [RequestLink:431386215] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK431386215
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK431386215.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FileFormatTests';
end;//TK431386215.GetFolder

function TK431386215.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '512DCAD901C3';
end;//TK431386215.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK431386215.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

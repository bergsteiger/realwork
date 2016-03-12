unit K480819960;
 {* [Requestlink:480819960] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K480819960.pas"
// Стереотип: "TestCase"

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
 TK480819960 = class(TArchiInsiderTest)
  {* [Requestlink:480819960] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK480819960
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK480819960.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'LoadText';
end;//TK480819960.GetFolder

function TK480819960.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '521F2ECB0129';
end;//TK480819960.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK480819960.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

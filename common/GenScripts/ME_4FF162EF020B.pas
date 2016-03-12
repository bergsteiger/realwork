unit K370389917;
 {* [Requestlink:370389917] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K370389917.pas"
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
 TK370389917 = class(TArchiInsiderTest)
  {* [Requestlink:370389917] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK370389917
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK370389917.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Drawing Tests';
end;//TK370389917.GetFolder

function TK370389917.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FF162EF020B';
end;//TK370389917.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK370389917.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

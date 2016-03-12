unit K309168151;
 {* [Requestlink:309168151] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K309168151.pas"
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
 TK309168151 = class(TArchiInsiderTest)
  {* [Requestlink:309168151] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK309168151
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK309168151.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SBSTests';
end;//TK309168151.GetFolder

function TK309168151.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4ED758D70321';
end;//TK309168151.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK309168151.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

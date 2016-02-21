unit K159367236;
 {* [Requestlink:159367236] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K159367236.pas"
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
 TK159367236 = class(TArchiInsiderTest)
  {* [Requestlink:159367236] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK159367236
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK159367236.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScrollTests';
end;//TK159367236.GetFolder

function TK159367236.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F4E05E60072';
end;//TK159367236.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK159367236.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

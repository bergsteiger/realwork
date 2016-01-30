unit K423593340;
 {* [Requestlink:423593340] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K423593340.pas"
// Стереотип: "TestCase"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK423593340 = class(TArchiInsiderTest)
  {* [Requestlink:423593340] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK423593340
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK423593340.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScrollTests';
end;//TK423593340.GetFolder

function TK423593340.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50EFBD870384';
end;//TK423593340.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK423593340.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

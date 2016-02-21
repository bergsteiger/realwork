unit K421111320;
 {* [Requestlink:421111320] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K421111320.pas"
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
 TK421111320 = class(TArchiInsiderTest)
  {* [Requestlink:421111320] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK421111320
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK421111320.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SelectionTests';
end;//TK421111320.GetFolder

function TK421111320.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50ED3862008B';
end;//TK421111320.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK421111320.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

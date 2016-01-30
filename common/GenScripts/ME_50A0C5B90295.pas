unit K407736033;
 {* [Requestlink:407736033] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K407736033.pas"
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
 TK407736033 = class(TArchiInsiderTest)
  {* [Requestlink:407736033] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK407736033
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK407736033.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScrollTests';
end;//TK407736033.GetFolder

function TK407736033.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50A0C5B90295';
end;//TK407736033.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK407736033.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

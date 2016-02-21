unit K382408648;
 {* [Requestlink:382408648] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K382408648.pas"
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
 TK382408648 = class(TArchiInsiderTest)
  {* [Requestlink:382408648] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK382408648
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK382408648.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK382408648.GetFolder

function TK382408648.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5023B65301D1';
end;//TK382408648.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK382408648.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

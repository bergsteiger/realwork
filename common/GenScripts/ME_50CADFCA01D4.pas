unit K407745210;
 {* [Requestlink:407745210] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K407745210.pas"
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
 TK407745210 = class(TArchiInsiderTest)
  {* [Requestlink:407745210] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK407745210
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK407745210.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK407745210.GetFolder

function TK407745210.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50CADFCA01D4';
end;//TK407745210.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK407745210.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

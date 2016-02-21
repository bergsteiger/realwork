unit K437519082;
 {* [Requestlink:437519082] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K437519082.pas"
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
 TK437519082 = class(TArchiInsiderTest)
  {* [Requestlink:437519082] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK437519082
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK437519082.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableBoundariesAlignment';
end;//TK437519082.GetFolder

function TK437519082.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5152EF6E00D7';
end;//TK437519082.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK437519082.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

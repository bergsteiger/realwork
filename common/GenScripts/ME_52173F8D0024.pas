unit K479402974;
 {* [Requestlink:479402974] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K479402974.pas"
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
 TK479402974 = class(TArchiInsiderTest)
  {* [Requestlink:479402974] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK479402974
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK479402974.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK479402974.GetFolder

function TK479402974.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '52173F8D0024';
end;//TK479402974.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK479402974.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

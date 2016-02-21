unit K370384999;
 {* [Requestlink:370384999] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K370384999.pas"
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
 TK370384999 = class(TArchiInsiderTest)
  {* [Requestlink:370384999] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK370384999
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK370384999.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Text2TableTests';
end;//TK370384999.GetFolder

function TK370384999.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FDAC1410288';
end;//TK370384999.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK370384999.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

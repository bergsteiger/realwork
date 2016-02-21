unit K105579791;
 {* [Requestlink:105579791] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K105579791.pas"
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
 TK105579791 = class(TArchiInsiderTest)
  {* [Requestlink:105579791] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK105579791
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK105579791.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Text2TableTests';
end;//TK105579791.GetFolder

function TK105579791.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FB4A05702DF';
end;//TK105579791.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK105579791.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

unit K434737002;
 {* [Requestlink:434737002] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K434737002.pas"
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
 TK434737002 = class(TArchiInsiderTest)
  {* [Requestlink:434737002] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK434737002
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK434737002.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DialogTest';
end;//TK434737002.GetFolder

function TK434737002.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5135C19D008F';
end;//TK434737002.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK434737002.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

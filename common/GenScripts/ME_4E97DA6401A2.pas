unit K290951686;
 {* [$290951686] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K290951686.pas"
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
 TK290951686 = class(TArchiInsiderTest)
  {* [$290951686] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK290951686
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK290951686.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK290951686.GetFolder

function TK290951686.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E97DA6401A2';
end;//TK290951686.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK290951686.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

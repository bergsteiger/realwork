unit K289276523;
 {* [$289276523] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K289276523.pas"
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
 TK289276523 = class(TArchiInsiderTest)
  {* [$289276523] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK289276523
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK289276523.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScrollTests';
end;//TK289276523.GetFolder

function TK289276523.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E8D60820179';
end;//TK289276523.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK289276523.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

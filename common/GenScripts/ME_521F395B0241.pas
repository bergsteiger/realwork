unit K480817440;
 {* [Requestlink:480817440] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K480817440.pas"
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
 TK480817440 = class(TArchiInsiderTest)
  {* [Requestlink:480817440] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK480817440
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK480817440.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'LoadText';
end;//TK480817440.GetFolder

function TK480817440.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '521F395B0241';
end;//TK480817440.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK480817440.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

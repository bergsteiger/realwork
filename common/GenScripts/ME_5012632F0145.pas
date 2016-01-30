unit K380044630;
 {* [Requestlink:380044630] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K380044630.pas"
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
 TK380044630 = class(TArchiInsiderTest)
  {* [Requestlink:380044630] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK380044630
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK380044630.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK380044630.GetFolder

function TK380044630.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5012632F0145';
end;//TK380044630.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK380044630.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

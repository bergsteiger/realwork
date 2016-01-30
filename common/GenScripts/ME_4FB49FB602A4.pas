unit K358365470;
 {* [Requestlink:358365470] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K358365470.pas"
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
 TK358365470 = class(TArchiInsiderTest)
  {* [Requestlink:358365470] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK358365470
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK358365470.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK358365470.GetFolder

function TK358365470.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FB49FB602A4';
end;//TK358365470.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358365470.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

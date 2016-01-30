unit K390585154;
 {* [Requestlink:390585154] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K390585154.pas"
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
 TK390585154 = class(TArchiInsiderTest)
  {* [Requestlink:390585154] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK390585154
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK390585154.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK390585154.GetFolder

function TK390585154.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5048AA03036F';
end;//TK390585154.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK390585154.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

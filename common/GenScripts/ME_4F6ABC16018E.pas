unit K349116289;
 {* [Requestlink:349116289] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K349116289.pas"
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
 TK349116289 = class(TArchiInsiderTest)
  {* [Requestlink:349116289] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK349116289
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK349116289.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK349116289.GetFolder

function TK349116289.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F6ABC16018E';
end;//TK349116289.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK349116289.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

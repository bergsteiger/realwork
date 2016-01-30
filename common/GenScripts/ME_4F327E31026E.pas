unit K336659951;
 {* [Requestlink:336659951] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K336659951.pas"
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
 TK336659951 = class(TArchiInsiderTest)
  {* [Requestlink:336659951] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK336659951
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK336659951.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK336659951.GetFolder

function TK336659951.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F327E31026E';
end;//TK336659951.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336659951.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

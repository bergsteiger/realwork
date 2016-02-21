unit K358976813;
 {* [Requestlink:358976813] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K358976813.pas"
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
 TK358976813 = class(TArchiInsiderTest)
  {* [Requestlink:358976813] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK358976813
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK358976813.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableResize';
end;//TK358976813.GetFolder

function TK358976813.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51AEE146019B';
end;//TK358976813.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358976813.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

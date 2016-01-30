unit K356060358;
 {* [Requestlink:356060358] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K356060358.pas"
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
 TK356060358 = class(TArchiInsiderTest)
  {* [Requestlink:356060358] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK356060358
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK356060358.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SelectionTests';
end;//TK356060358.GetFolder

function TK356060358.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F7C1F48010A';
end;//TK356060358.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK356060358.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

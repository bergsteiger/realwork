unit K323059794;
 {* [Requestlink:323059794] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K323059794.pas"
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
 TK323059794 = class(TArchiInsiderTest)
  {* [Requestlink:323059794] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK323059794
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK323059794.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DialogTest';
end;//TK323059794.GetFolder

function TK323059794.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F0C263E03BD';
end;//TK323059794.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK323059794.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

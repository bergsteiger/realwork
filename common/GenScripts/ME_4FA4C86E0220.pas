unit K362973200;
 {* [Requestlink:362973200] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K362973200.pas"
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
 TK362973200 = class(TArchiInsiderTest)
  {* [Requestlink:362973200] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK362973200
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK362973200.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableBoundariesAlignment';
end;//TK362973200.GetFolder

function TK362973200.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FA4C86E0220';
end;//TK362973200.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK362973200.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

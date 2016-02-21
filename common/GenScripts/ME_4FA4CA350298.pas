unit K362975266;
 {* [Requestlink:362973200] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K362975266.pas"
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
 TK362975266 = class(TArchiInsiderTest)
  {* [Requestlink:362973200] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK362975266
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK362975266.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableBoundariesAlignment';
end;//TK362975266.GetFolder

function TK362975266.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FA4CA350298';
end;//TK362975266.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK362975266.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

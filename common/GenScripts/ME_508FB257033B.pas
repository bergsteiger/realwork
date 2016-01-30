unit K407150878;
 {* [Requestlink:407150878] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K407150878.pas"
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
 TK407150878 = class(TArchiInsiderTest)
  {* [Requestlink:407150878] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK407150878
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK407150878.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScrollTests';
end;//TK407150878.GetFolder

function TK407150878.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '508FB257033B';
end;//TK407150878.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK407150878.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

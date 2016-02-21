unit K371636355;
 {* [Requestlink:371636355] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K371636355.pas"
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
 TK371636355 = class(TArchiInsiderTest)
  {* [Requestlink:371636355] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK371636355
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK371636355.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK371636355.GetFolder

function TK371636355.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FF29C5102A8';
end;//TK371636355.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK371636355.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

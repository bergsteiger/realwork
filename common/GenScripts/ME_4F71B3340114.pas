unit K352455870;
 {* [Requestlink:352455870] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K352455870.pas"
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
 TK352455870 = class(TArchiInsiderTest)
  {* [Requestlink:352455870] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK352455870
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK352455870.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK352455870.GetFolder

function TK352455870.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F71B3340114';
end;//TK352455870.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK352455870.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

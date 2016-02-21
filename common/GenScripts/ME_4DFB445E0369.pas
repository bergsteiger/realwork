unit K266421641;
 {* [$266421641] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K266421641.pas"
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
 TK266421641 = class(TArchiInsiderTest)
  {* [$266421641] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK266421641
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK266421641.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK266421641.GetFolder

function TK266421641.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DFB445E0369';
end;//TK266421641.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK266421641.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

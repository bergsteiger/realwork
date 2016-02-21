unit K424381826;
 {* [Requestlink:424381826] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K424381826.pas"
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
 TK424381826 = class(TArchiInsiderTest)
  {* [Requestlink:424381826] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK424381826
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK424381826.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ColumnResize';
end;//TK424381826.GetFolder

function TK424381826.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50F7C3A20106';
end;//TK424381826.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK424381826.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

unit K342862858;
 {* [Requestlink:342862858] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K342862858.pas"
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
 TK342862858 = class(TArchiInsiderTest)
  {* [Requestlink:342862858] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK342862858
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK342862858.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK342862858.GetFolder

function TK342862858.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F50C48F01E0';
end;//TK342862858.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK342862858.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

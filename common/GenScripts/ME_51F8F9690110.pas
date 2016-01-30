unit K161121021;
 {* [Requestlink:161121021] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K161121021.pas"
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
 TK161121021 = class(TArchiInsiderTest)
  {* [Requestlink:161121021] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK161121021
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK161121021.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK161121021.GetFolder

function TK161121021.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51F8F9690110';
end;//TK161121021.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK161121021.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

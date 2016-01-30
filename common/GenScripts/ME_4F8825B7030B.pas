unit K358355026;
 {* [Requestlink:358355026] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K358355026.pas"
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
 TK358355026 = class(TArchiInsiderTest)
  {* [Requestlink:358355026] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK358355026
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK358355026.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK358355026.GetFolder

function TK358355026.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F8825B7030B';
end;//TK358355026.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358355026.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

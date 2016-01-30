unit K371644395;
 {* [Requestlink:371644395] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K371644395.pas"
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
 TK371644395 = class(TArchiInsiderTest)
  {* [Requestlink:371644395] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK371644395
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK371644395.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK371644395.GetFolder

function TK371644395.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FFC003802F7';
end;//TK371644395.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK371644395.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

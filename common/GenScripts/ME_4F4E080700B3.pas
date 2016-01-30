unit K338005013;
 {* [Requestlink:338005013] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K338005013.pas"
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
 TK338005013 = class(TArchiInsiderTest)
  {* [Requestlink:338005013] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK338005013
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK338005013.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SelectionTests';
end;//TK338005013.GetFolder

function TK338005013.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F4E080700B3';
end;//TK338005013.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK338005013.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

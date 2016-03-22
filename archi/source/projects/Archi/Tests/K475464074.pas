unit K475464074;
 {* [Requestlink:475464074] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K475464074.pas"
// Стереотип: "TestCase"
// Элемент модели: "K475464074" MUID: (51F8F9DB0256)
// Имя типа: "TK475464074"

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
 TK475464074 = class(TArchiInsiderTest)
  {* [Requestlink:475464074] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK475464074
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK475464074.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK475464074.GetFolder

function TK475464074.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51F8F9DB0256';
end;//TK475464074.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK475464074.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

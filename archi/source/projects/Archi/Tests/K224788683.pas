unit K224788683;
 {* [Requestlink:224788683] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K224788683.pas"
// Стереотип: "TestCase"
// Элемент модели: "K224788683" MUID: (4EF1939A0278)
// Имя типа: "TK224788683"

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
 TK224788683 = class(TArchiInsiderTest)
  {* [Requestlink:224788683] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK224788683
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK224788683.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK224788683.GetFolder

function TK224788683.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EF1939A0278';
end;//TK224788683.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK224788683.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

unit K349118532;
 {* [Requestlink:349118532] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K349118532.pas"
// Стереотип: "TestCase"
// Элемент модели: "K349118532" MUID: (4F69E211003C)
// Имя типа: "TK349118532"

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
 TK349118532 = class(TArchiInsiderTest)
  {* [Requestlink:349118532] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK349118532
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK349118532.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK349118532.GetFolder

function TK349118532.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F69E211003C';
end;//TK349118532.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK349118532.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

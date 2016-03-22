unit K336658853;
 {* [Requestlink:336658853] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K336658853.pas"
// Стереотип: "TestCase"
// Элемент модели: "K336658853" MUID: (4F3271CA0068)
// Имя типа: "TK336658853"

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
 TK336658853 = class(TArchiInsiderTest)
  {* [Requestlink:336658853] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK336658853
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK336658853.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'OEMTextTests';
end;//TK336658853.GetFolder

function TK336658853.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F3271CA0068';
end;//TK336658853.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336658853.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

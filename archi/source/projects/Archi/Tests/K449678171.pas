unit K449678171;
 {* [Requestlink:449678171] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K449678171.pas"
// Стереотип: "TestCase"
// Элемент модели: "K449678171" MUID: (51DBB4910007)
// Имя типа: "TK449678171"

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
 TK449678171 = class(TArchiInsiderTest)
  {* [Requestlink:449678171] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK449678171
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK449678171.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK449678171.GetFolder

function TK449678171.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51DBB4910007';
end;//TK449678171.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK449678171.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

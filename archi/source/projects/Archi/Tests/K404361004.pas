unit K404361004;
 {* [Requestlink:404361004] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K404361004.pas"
// Стереотип: "TestCase"
// Элемент модели: "K404361004" MUID: (50AF42CD0309)
// Имя типа: "TK404361004"

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
 TK404361004 = class(TArchiInsiderTest)
  {* [Requestlink:404361004] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK404361004
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK404361004.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScrollTests';
end;//TK404361004.GetFolder

function TK404361004.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50AF42CD0309';
end;//TK404361004.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK404361004.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

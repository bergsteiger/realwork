unit K281519812;
 {* [Requestlink:281519812] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K281519812.pas"
// Стереотип: "TestCase"
// Элемент модели: "K281519812" MUID: (521610740357)
// Имя типа: "TK281519812"

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
 TK281519812 = class(TArchiInsiderTest)
  {* [Requestlink:281519812] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK281519812
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK281519812.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK281519812.GetFolder

function TK281519812.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '521610740357';
end;//TK281519812.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK281519812.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

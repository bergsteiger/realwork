unit K449024991;
 {* [Requestlink:449024991] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K449024991.pas"
// Стереотип: "TestCase"
// Элемент модели: "K449024991" MUID: (5166830C0027)
// Имя типа: "TK449024991"

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
 TK449024991 = class(TArchiInsiderTest)
  {* [Requestlink:449024991] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK449024991
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK449024991.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK449024991.GetFolder

function TK449024991.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5166830C0027';
end;//TK449024991.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK449024991.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

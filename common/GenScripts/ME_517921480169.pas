unit K431359667;
 {* [Requestlink:431359667] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K431359667.pas"
// Стереотип: "TestCase"
// Элемент модели: "K431359667" MUID: (517921480169)
// Имя типа: "TK431359667"

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
 TK431359667 = class(TArchiInsiderTest)
  {* [Requestlink:431359667] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK431359667
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK431359667.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK431359667.GetFolder

function TK431359667.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '517921480169';
end;//TK431359667.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK431359667.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

unit K339869830;
 {* [Requestlink:339869830] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K339869830.pas"
// Стереотип: "TestCase"
// Элемент модели: "K339869830" MUID: (4F3E49840360)
// Имя типа: "TK339869830"

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
 TK339869830 = class(TArchiInsiderTest)
  {* [Requestlink:339869830] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK339869830
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK339869830.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK339869830.GetFolder

function TK339869830.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F3E49840360';
end;//TK339869830.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK339869830.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

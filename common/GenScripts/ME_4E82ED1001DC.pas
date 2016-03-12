unit K281520291;
 {* [Requestlink:281520291] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K281520291.pas"
// Стереотип: "TestCase"

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
 TK281520291 = class(TArchiInsiderTest)
  {* [Requestlink:281520291] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK281520291
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK281520291.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Drawing Tests';
end;//TK281520291.GetFolder

function TK281520291.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E82ED1001DC';
end;//TK281520291.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK281520291.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

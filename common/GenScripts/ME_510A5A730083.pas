unit K425273506;
 {* [Requestlink:425273506] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K425273506.pas"
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
 TK425273506 = class(TArchiInsiderTest)
  {* [Requestlink:425273506] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK425273506
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK425273506.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'InnerTable';
end;//TK425273506.GetFolder

function TK425273506.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '510A5A730083';
end;//TK425273506.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK425273506.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

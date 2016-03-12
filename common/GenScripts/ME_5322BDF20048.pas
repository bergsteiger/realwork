unit K517791575;
 {* [Requestlink:517791575] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K517791575.pas"
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
 TK517791575 = class(TArchiInsiderTest)
  {* [Requestlink:517791575] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK517791575
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK517791575.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'LoadText';
end;//TK517791575.GetFolder

function TK517791575.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5322BDF20048';
end;//TK517791575.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK517791575.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

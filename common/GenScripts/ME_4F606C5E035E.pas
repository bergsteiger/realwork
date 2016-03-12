unit K342859055;
 {* [Requestlink:342859055] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K342859055.pas"
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
 TK342859055 = class(TArchiInsiderTest)
  {* [Requestlink:342859055] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK342859055
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK342859055.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'KeyWordsTest';
end;//TK342859055.GetFolder

function TK342859055.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F606C5E035E';
end;//TK342859055.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK342859055.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

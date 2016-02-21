unit K320743144;
 {* [Requestlink:320743144] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K320743144.pas"
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
 TK320743144 = class(TArchiInsiderTest)
  {* [Requestlink:320743144] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK320743144
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK320743144.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SBSTests';
end;//TK320743144.GetFolder

function TK320743144.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EF03F8103BB';
end;//TK320743144.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK320743144.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

unit K363564248;
 {* [Requestlink:363564248] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K363564248.pas"
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
 TK363564248 = class(TArchiInsiderTest)
  {* [Requestlink:363564248] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK363564248
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK363564248.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Text2TableTests';
end;//TK363564248.GetFolder

function TK363564248.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FAE352C0181';
end;//TK363564248.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK363564248.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

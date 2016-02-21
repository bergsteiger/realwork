unit K336660676;
 {* [Requestlink:336660676] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K336660676.pas"
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
 TK336660676 = class(TArchiInsiderTest)
  {* [Requestlink:336660676] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK336660676
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK336660676.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK336660676.GetFolder

function TK336660676.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F339DA501A7';
end;//TK336660676.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336660676.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

unit K380604713;
 {* [Requestlink:380604713] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K380604713.pas"
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
 TK380604713 = class(TArchiInsiderTest)
  {* [Requestlink:380604713] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK380604713
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK380604713.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK380604713.GetFolder

function TK380604713.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5017CA2F0220';
end;//TK380604713.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK380604713.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

unit K297698018;
 {* [Requestlink:297698018] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K297698018.pas"
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
 TK297698018 = class(TArchiInsiderTest)
  {* [Requestlink:297698018] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK297698018
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK297698018.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK297698018.GetFolder

function TK297698018.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EBA1C5002AF';
end;//TK297698018.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK297698018.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

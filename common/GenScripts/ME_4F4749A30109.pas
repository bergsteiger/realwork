unit K340165072;
 {* [Requestlink:340165072] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K340165072.pas"
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
 TK340165072 = class(TArchiInsiderTest)
  {* [Requestlink:340165072] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK340165072
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK340165072.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK340165072.GetFolder

function TK340165072.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F4749A30109';
end;//TK340165072.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK340165072.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

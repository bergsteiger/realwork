unit K344130696;
 {* [Requestlink:344130696] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K344130696.pas"
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
 TK344130696 = class(TArchiInsiderTest)
  {* [Requestlink:344130696] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK344130696
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK344130696.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK344130696.GetFolder

function TK344130696.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F5C65F403D7';
end;//TK344130696.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK344130696.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

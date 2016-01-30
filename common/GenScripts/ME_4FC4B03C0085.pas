unit K365824453;
 {* [Requestlink:365824453] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K365824453.pas"
// Стереотип: "TestCase"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK365824453 = class(TArchiInsiderTest)
  {* [Requestlink:365824453] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK365824453
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK365824453.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableBoundariesAlignment';
end;//TK365824453.GetFolder

function TK365824453.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FC4B03C0085';
end;//TK365824453.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK365824453.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

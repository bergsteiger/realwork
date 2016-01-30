unit K452392846;
 {* [Requestlink:452392846] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K452392846.pas"
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
 TK452392846 = class(TArchiInsiderTest)
  {* [Requestlink:452392846] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK452392846
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK452392846.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK452392846.GetFolder

function TK452392846.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '517E5B500353';
end;//TK452392846.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK452392846.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

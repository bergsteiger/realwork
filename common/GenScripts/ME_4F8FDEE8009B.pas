unit K358976777;
 {* [Requestlink:358976777] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K358976777.pas"
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
 TK358976777 = class(TArchiInsiderTest)
  {* [Requestlink:358976777] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK358976777
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK358976777.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DialogTest';
end;//TK358976777.GetFolder

function TK358976777.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F8FDEE8009B';
end;//TK358976777.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358976777.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

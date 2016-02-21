unit K407150344;
 {* [Requestlink:407150344] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K407150344.pas"
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
 TK407150344 = class(TArchiInsiderTest)
  {* [Requestlink:407150344] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK407150344
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK407150344.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK407150344.GetFolder

function TK407150344.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '509277C40387';
end;//TK407150344.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK407150344.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

unit K447393371;
 {* [Requestlink:447393371] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K447393371.pas"
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
 TK447393371 = class(TArchiInsiderTest)
  {* [Requestlink:447393371] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK447393371
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK447393371.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'MacrosTest';
end;//TK447393371.GetFolder

function TK447393371.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5162771D0104';
end;//TK447393371.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK447393371.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

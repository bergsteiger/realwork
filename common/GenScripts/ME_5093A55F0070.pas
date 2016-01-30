unit K407150049;
 {* [Requestlink:407150049] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K407150049.pas"
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
 TK407150049 = class(TArchiInsiderTest)
  {* [Requestlink:407150049] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK407150049
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK407150049.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SelectionTests';
end;//TK407150049.GetFolder

function TK407150049.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5093A55F0070';
end;//TK407150049.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK407150049.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

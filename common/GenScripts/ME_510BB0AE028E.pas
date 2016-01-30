unit K425263512;
 {* [Requestlink:425263512] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K425263512.pas"
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
 TK425263512 = class(TArchiInsiderTest)
  {* [Requestlink:425263512] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK425263512
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK425263512.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'InnerTable';
end;//TK425263512.GetFolder

function TK425263512.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '510BB0AE028E';
end;//TK425263512.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK425263512.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

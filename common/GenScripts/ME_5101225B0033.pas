unit K425040715;
 {* [Requestlink:425040715] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K425040715.pas"
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
 TK425040715 = class(TArchiInsiderTest)
  {* [Requestlink:425040715] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK425040715
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK425040715.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableBoundariesAlignment';
end;//TK425040715.GetFolder

function TK425040715.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5101225B0033';
end;//TK425040715.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK425040715.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

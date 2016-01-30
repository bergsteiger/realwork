unit K323061070;
 {* [RequestLink:323061070] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K323061070.pas"
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
 TK323061070 = class(TArchiInsiderTest)
  {* [RequestLink:323061070] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK323061070
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK323061070.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK323061070.GetFolder

function TK323061070.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EF86F3203E5';
end;//TK323061070.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK323061070.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

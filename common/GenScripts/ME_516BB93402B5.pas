unit K377750479;
 {* [Requestlink:377750479] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K377750479.pas"
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
 TK377750479 = class(TArchiInsiderTest)
  {* [Requestlink:377750479] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK377750479
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK377750479.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK377750479.GetFolder

function TK377750479.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '516BB93402B5';
end;//TK377750479.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK377750479.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

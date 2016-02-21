unit K280010450;
 {* [$280010450] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K280010450.pas"
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
 TK280010450 = class(TArchiInsiderTest)
  {* [$280010450] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK280010450
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK280010450.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK280010450.GetFolder

function TK280010450.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E60735700CA';
end;//TK280010450.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK280010450.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.

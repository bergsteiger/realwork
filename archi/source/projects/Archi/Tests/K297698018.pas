unit K297698018;
 {* [Requestlink:297698018] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K297698018.pas"
// Стереотип: "TestCase"
// Элемент модели: "K297698018" MUID: (4EBA1C5002AF)
// Имя типа: "TK297698018"

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
 TK297698018 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:297698018] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK297698018
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4EBA1C5002AFimpl_uses*
 //#UC END# *4EBA1C5002AFimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK297698018.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK297698018.GetFolder

function TK297698018.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EBA1C5002AF';
end;//TK297698018.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK297698018.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

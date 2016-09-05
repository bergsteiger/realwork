unit K389942714;
 {* [Requestlink:389942714] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K389942714.pas"
// Стереотип: "TestCase"
// Элемент модели: "K389942714" MUID: (504497A0037B)
// Имя типа: "TK389942714"

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
 TK389942714 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:389942714] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK389942714
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *504497A0037Bimpl_uses*
 //#UC END# *504497A0037Bimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK389942714.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DialogTest';
end;//TK389942714.GetFolder

function TK389942714.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '504497A0037B';
end;//TK389942714.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK389942714.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

unit K296621183;
 {* [Requestlink:296621183] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K296621183.pas"
// Стереотип: "TestCase"
// Элемент модели: "K296621183" MUID: (4EAFCDB40089)
// Имя типа: "TK296621183"

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
 TK296621183 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:296621183] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK296621183
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4EAFCDB40089impl_uses*
 //#UC END# *4EAFCDB40089impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK296621183.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK296621183.GetFolder

function TK296621183.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EAFCDB40089';
end;//TK296621183.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK296621183.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

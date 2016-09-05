unit K345637305;
 {* [Requestlink:345637305] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K345637305.pas"
// Стереотип: "TestCase"
// Элемент модели: "K345637305" MUID: (4F60A9A50191)
// Имя типа: "TK345637305"

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
 TK345637305 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:345637305] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK345637305
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F60A9A50191impl_uses*
 //#UC END# *4F60A9A50191impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK345637305.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK345637305.GetFolder

function TK345637305.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F60A9A50191';
end;//TK345637305.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK345637305.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

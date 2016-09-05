unit K437125222;
 {* [Requestlink:437125222] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K437125222.pas"
// Стереотип: "TestCase"
// Элемент модели: "TK437125222" MUID: (5142F6DD03A7)

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
 TK437125222 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:437125222] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK437125222
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5142F6DD03A7impl_uses*
 //#UC END# *5142F6DD03A7impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK437125222.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DialogTest';
end;//TK437125222.GetFolder

function TK437125222.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5142F6DD03A7';
end;//TK437125222.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK437125222.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

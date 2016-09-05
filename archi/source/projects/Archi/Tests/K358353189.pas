unit K358353189;
 {* [Requestlink:358353189] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K358353189.pas"
// Стереотип: "TestCase"
// Элемент модели: "K358353189" MUID: (4F87CFB600D1)
// Имя типа: "TK358353189"

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
 TK358353189 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:358353189] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK358353189
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F87CFB600D1impl_uses*
 //#UC END# *4F87CFB600D1impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK358353189.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK358353189.GetFolder

function TK358353189.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F87CFB600D1';
end;//TK358353189.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358353189.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

unit K382420133;
 {* [Requestlink:382420133] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K382420133.pas"
// Стереотип: "TestCase"
// Элемент модели: "K382420133" MUID: (5029F7BC03A6)
// Имя типа: "TK382420133"

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
 TK382420133 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:382420133] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK382420133
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5029F7BC03A6impl_uses*
 //#UC END# *5029F7BC03A6impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK382420133.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Drawing Tests';
end;//TK382420133.GetFolder

function TK382420133.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5029F7BC03A6';
end;//TK382420133.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK382420133.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

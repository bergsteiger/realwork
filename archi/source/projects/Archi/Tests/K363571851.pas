unit K363571851;
 {* [Requestlink:363571851] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K363571851.pas"
// Стереотип: "TestCase"
// Элемент модели: "K363571851" MUID: (4FAE524401E4)
// Имя типа: "TK363571851"

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
 TK363571851 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:363571851] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK363571851
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4FAE524401E4impl_uses*
 //#UC END# *4FAE524401E4impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK363571851.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Text2TableTests';
end;//TK363571851.GetFolder

function TK363571851.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FAE524401E4';
end;//TK363571851.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK363571851.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

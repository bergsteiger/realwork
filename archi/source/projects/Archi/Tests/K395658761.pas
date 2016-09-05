unit K395658761;
 {* [Requestlink:395658761] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K395658761.pas"
// Стереотип: "TestCase"
// Элемент модели: "K395658761" MUID: (506A965C0032)
// Имя типа: "TK395658761"

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
 TK395658761 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:395658761] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK395658761
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *506A965C0032impl_uses*
 //#UC END# *506A965C0032impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK395658761.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK395658761.GetFolder

function TK395658761.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '506A965C0032';
end;//TK395658761.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK395658761.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

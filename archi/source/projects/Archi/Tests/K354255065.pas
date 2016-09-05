unit K354255065;
 {* [Requestlink:354255065] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K354255065.pas"
// Стереотип: "TestCase"
// Элемент модели: "K354255065" MUID: (4F759A710336)
// Имя типа: "TK354255065"

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
 TK354255065 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:354255065] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK354255065
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F759A710336impl_uses*
 //#UC END# *4F759A710336impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK354255065.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK354255065.GetFolder

function TK354255065.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F759A710336';
end;//TK354255065.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK354255065.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

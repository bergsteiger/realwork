unit K280007486;
 {* [$280007486] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K280007486.pas"
// Стереотип: "TestCase"
// Элемент модели: "K280007486" MUID: (4E5789F40148)
// Имя типа: "TK280007486"

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
 TK280007486 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [$280007486] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK280007486
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4E5789F40148impl_uses*
 //#UC END# *4E5789F40148impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK280007486.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK280007486.GetFolder

function TK280007486.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E5789F40148';
end;//TK280007486.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK280007486.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.

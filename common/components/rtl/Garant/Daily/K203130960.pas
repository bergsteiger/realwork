unit K203130960;
 {* [RequestLink:203130960]. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K203130960.pas"
// Стереотип: "TestCase"
// Элемент модели: "K203130960" MUID: (4C0E2C7A0123)
// Имя типа: "TK203130960"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollBackTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK203130960 = class({$If NOT Defined(NoVCM)}
 TScrollBackTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:203130960]. }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK203130960
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4C0E2C7A0123impl_uses*
 //#UC END# *4C0E2C7A0123impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK203130960.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK203130960.GetFolder

function TK203130960.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C0E2C7A0123';
end;//TK203130960.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK203130960.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.

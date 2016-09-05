unit K217680060;
 {* [RequestLink:217680060] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K217680060.pas"
// Стереотип: "TestCase"
// Элемент модели: "K217680060" MUID: (4C0D206B03E5)
// Имя типа: "TK217680060"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK217680060 = class({$If NOT Defined(NoVCM)}
 TScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:217680060] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK217680060
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
 //#UC START# *4C0D206B03E5impl_uses*
 //#UC END# *4C0D206B03E5impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK217680060.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK217680060.GetFolder

function TK217680060.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C0D206B03E5';
end;//TK217680060.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217680060.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.

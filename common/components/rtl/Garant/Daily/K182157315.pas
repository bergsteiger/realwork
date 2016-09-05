unit K182157315;
 {* [RequestLink:182157315] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K182157315.pas"
// Стереотип: "TestCase"
// Элемент модели: "K182157315" MUID: (4D63DDD901EC)
// Имя типа: "TK182157315"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTestBefore278833302
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK182157315 = class({$If NOT Defined(NoVCM)}
 TPreviewTestBefore278833302
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:182157315] }
  protected
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK182157315
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
 //#UC START# *4D63DDD901ECimpl_uses*
 //#UC END# *4D63DDD901ECimpl_uses*
;

{$If NOT Defined(NoVCM)}
{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK182157315.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4D63DDD901EC_var*
//#UC END# *51AF49E5001B_4D63DDD901EC_var*
begin
//#UC START# *51AF49E5001B_4D63DDD901EC_impl*
 Result := true;
//#UC END# *51AF49E5001B_4D63DDD901EC_impl*
end;//TK182157315.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK182157315.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK182157315.GetFolder

function TK182157315.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D63DDD901EC';
end;//TK182157315.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK182157315.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.

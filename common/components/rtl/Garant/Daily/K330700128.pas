unit K330700128;
 {* [Requestlink:330700128] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K330700128.pas"
// Стереотип: "TestCase"
// Элемент модели: "K330700128" MUID: (4F22949102E5)
// Имя типа: "TK330700128"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK330700128 = class({$If NOT Defined(NoVCM)}
 TPreviewTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [Requestlink:330700128] }
  protected
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK330700128
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
 //#UC START# *4F22949102E5impl_uses*
 //#UC END# *4F22949102E5impl_uses*
;

{$If NOT Defined(NoVCM)}
{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TK330700128.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4F22949102E5_var*
//#UC END# *51AF49E5001B_4F22949102E5_var*
begin
//#UC START# *51AF49E5001B_4F22949102E5_impl*
 Result := true;
//#UC END# *51AF49E5001B_4F22949102E5_impl*
end;//TK330700128.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

function TK330700128.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK330700128.GetFolder

function TK330700128.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F22949102E5';
end;//TK330700128.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK330700128.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.

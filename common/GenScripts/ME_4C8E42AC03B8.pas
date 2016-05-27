unit PrimCustomizeTools_Form;

// Модуль: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\PrimCustomizeTools_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimCustomizeTools" MUID: (4C8E42AC03B8)
// Имя типа: "TPrimCustomizeToolsForm"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
 , vcmEntityForm
;

type
 TPrimCustomizeToolsForm = class(TvcmEntityForm)
 end;//TPrimCustomizeToolsForm
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , StdRes
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimCustomizeToolsForm);
 {* Регистрация PrimCustomizeTools }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.

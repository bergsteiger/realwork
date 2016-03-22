unit PrimAttributeSelectOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelectOptions_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimAttributeSelectOptions" MUID: (4C88C855017E)
// Имя типа: "TPrimAttributeSelectOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimAttributeSelect_Form
;

type
 TPrimAttributeSelectOptionsForm = class(TPrimAttributeSelectForm)
 end;//TPrimAttributeSelectOptionsForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAttributeSelectOptionsForm);
 {* Регистрация PrimAttributeSelectOptions }
{$IfEnd} // NOT Defined(NoScripts)

end.

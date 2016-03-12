unit PrimDocumentWithFlashOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDocumentWithFlashOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDocumentWithFlash_Form
;

type
 TPrimDocumentWithFlashOptionsForm = class(TPrimDocumentWithFlashForm)
 end;//TPrimDocumentWithFlashOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDocumentWithFlashOptionsForm);
 {* Регистрация PrimDocumentWithFlashOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

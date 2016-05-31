unit NOT_COMPLETED_ShellAndMonitoringsMain_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_COMPLETED_ShellAndMonitoringsMain_Form.pas"
// Стереотип: "VCMMainForm"
// Элемент модели: "ShellAndMonitoringsMain" MUID: (4AAA43F601F7)
// Имя типа: "TShellAndMonitoringsMainForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimMainOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TShellAndMonitoringsMainForm = class(TPrimMainOptionsForm)
 end;//TShellAndMonitoringsMainForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4AAA43F601F7impl_uses*
 //#UC END# *4AAA43F601F7impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TShellAndMonitoringsMainForm);
 {* Регистрация ShellAndMonitoringsMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.

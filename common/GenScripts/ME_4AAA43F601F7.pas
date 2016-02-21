unit ShellAndMonitoringsMain_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ShellAndMonitoringsMain_Form.pas"
// Стереотип: "VCMMainForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimMainOptions_Form
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
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TShellAndMonitoringsMainForm);
 {* Регистрация ShellAndMonitoringsMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.

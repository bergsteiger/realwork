unit ShellAndMonitoringsMain_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ShellAndMonitoringsMain_Form.pas"
// ���������: "VCMMainForm"

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
 {* ����������� ShellAndMonitoringsMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.

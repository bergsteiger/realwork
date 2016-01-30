unit ShellAndMonitoringsRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ShellAndMonitoringsRes.pas"
// Стереотип: "VCMApplication"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimF1Res
;

type
 TShellAndMonitoringsMainForm = class(TPrimMainOptionsForm)
 end;//TShellAndMonitoringsMainForm

 TShellAndMonitoringsRes = {abstract} class(TPrimF1Res)
 end;//TShellAndMonitoringsRes
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , moCommonSearch
 , tasSaveLoadRealization
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

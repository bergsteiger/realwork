unit EditionsRes_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\EditionsRes_Form.pas"
// ���������: "VCMDataModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimEditionsRes_Form
;

type
 TEditionsResForm = {final} class(TPrimEditionsResForm)
 end;//TEditionsResForm
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
 TtfwClassRef.Register(TEditionsResForm);
 {* ����������� EditionsRes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

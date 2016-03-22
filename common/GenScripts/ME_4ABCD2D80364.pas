unit UnderControl_Form;
 {* �� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\Forms\UnderControl_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "UnderControl" MUID: (4ABCD2D80364)
// ��� ����: "TenUnderControl"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimUnderControlOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TenUnderControl = {final} class(TPrimUnderControlOptionsForm, UnderControlFormDef)
  {* �� �������� }
 end;//TenUnderControl
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , UnderControlKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenUnderControl);
 {* ����������� UnderControl }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enUnderControl.SetFactory(TenUnderControl.Make);
 {* ����������� ������� ����� UnderControl }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

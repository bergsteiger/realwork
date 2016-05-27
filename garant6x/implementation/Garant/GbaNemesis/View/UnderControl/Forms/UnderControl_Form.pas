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
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TenUnderControl = {final} class(TPrimUnderControlOptionsForm, UnderControlFormDef)
  {* �� �������� }
   Entities : TvcmEntities;
 end;//TenUnderControl
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , UnderControlKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_enUnderControl.SetFactory(TenUnderControl.Make);
 {* ����������� ������� ����� UnderControl }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenUnderControl);
 {* ����������� UnderControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

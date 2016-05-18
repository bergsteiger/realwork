unit UserProperty_Form;
 {* �������� ������������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\UserProperty_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "UserProperty" MUID: (4AA8E47C0065)
// ��� ����: "TefUserProperty"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimUserPropertyOptions_Form
 , Admin_FormDefinitions_Controls
;

type
 TefUserProperty = {final} class(TPrimUserPropertyOptionsForm, UserPropertyFormDef)
  {* �������� ������������ }
 end;//TefUserProperty
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , UserPropertyKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefUserProperty);
 {* ����������� UserProperty }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efUserProperty.SetFactory(TefUserProperty.Make);
 {* ����������� ������� ����� UserProperty }
{$IfEnd} // Defined(Admin)

end.

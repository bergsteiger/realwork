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
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TefUserProperty = {final} class(TPrimUserPropertyOptionsForm, UserPropertyFormDef)
  {* �������� ������������ }
   Entities : TvcmEntities;
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

{$R *.DFM}

initialization
 fm_efUserProperty.SetFactory(TefUserProperty.Make);
 {* ����������� ������� ����� UserProperty }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefUserProperty);
 {* ����������� UserProperty }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.

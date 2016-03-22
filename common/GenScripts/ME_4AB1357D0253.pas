unit Attributes_Form;
 {* ���������� � ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Attributes_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "Attributes" MUID: (4AB1357D0253)
// ��� ����: "TAttributesForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimAttributesOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TAttributesForm = {final} class(TPrimAttributesOptionsForm, AttributesFormDef)
  {* ���������� � ��������� }
 end;//TAttributesForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , AttributesKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAttributesForm);
 {* ����������� Attributes }
{$IfEnd} // NOT Defined(NoScripts)
 fm_AttributesForm.SetFactory(TAttributesForm.Make);
 {* ����������� ������� ����� Attributes }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

unit AttributeSelect_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\AttributeSelect_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "AttributeSelect" MUID: (4AAF4F89035C)
// ��� ����: "TcfAttributeSelect"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimAttributeSelectOptions_Form
 , SearchLite_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TcfAttributeSelect = {final} class(TPrimAttributeSelectOptionsForm, AttributeSelectFormDef)
   Entities : TvcmEntities;
 end;//TcfAttributeSelect

implementation

uses
 l3ImplUses
 , l3String
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , AttributeSelectKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_cfAttributeSelect.SetFactory(TcfAttributeSelect.Make);
 {* ����������� ������� ����� AttributeSelect }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TcfAttributeSelect);
 {* ����������� AttributeSelect }
{$IfEnd} // NOT Defined(NoScripts)

end.

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
;

type
 TcfAttributeSelect = {final} class(TPrimAttributeSelectOptionsForm, AttributeSelectFormDef)
 end;//TcfAttributeSelect

implementation

uses
 l3ImplUses
 , l3String
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , AttributeSelectKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TcfAttributeSelect);
 {* ����������� AttributeSelect }
{$IfEnd} // NOT Defined(NoScripts)
 fm_cfAttributeSelect.SetFactory(TcfAttributeSelect.Make);
 {* ����������� ������� ����� AttributeSelect }

end.

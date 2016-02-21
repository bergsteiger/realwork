unit TreeAttributeSelect_Form;
 {* ����� �������� ������������ �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\TreeAttributeSelect_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelectOptions_Form
 , SearchLite_FormDefinitions_Controls
;

type
 TefTreeAttributeSelect = {final} class(TPrimTreeAttributeSelectOptionsForm, TreeAttributeSelectFormDef)
  {* ����� �������� ������������ �������� }
 end;//TefTreeAttributeSelect

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TreeAttributeSelectKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefTreeAttributeSelect);
 {* ����������� TreeAttributeSelect }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efTreeAttributeSelect.SetFactory(TefTreeAttributeSelect.Make);
 {* ����������� ������� ����� TreeAttributeSelect }

end.

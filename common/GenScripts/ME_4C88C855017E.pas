unit PrimAttributeSelectOptions_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelectOptions_Form.pas"
// ���������: "VCMContainer"
// ������� ������: "PrimAttributeSelectOptions" MUID: (4C88C855017E)
// ��� ����: "TPrimAttributeSelectOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimAttributeSelect_Form
;

type
 TPrimAttributeSelectOptionsForm = class(TPrimAttributeSelectForm)
 end;//TPrimAttributeSelectOptionsForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAttributeSelectOptionsForm);
 {* ����������� PrimAttributeSelectOptions }
{$IfEnd} // NOT Defined(NoScripts)

end.

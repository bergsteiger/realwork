unit PrimGroupListOptions_Form;
 {* ������ ������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupListOptions_Form.pas"
// ���������: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimGroupList_Form
;

type
 TPrimGroupListOptionsForm = class(TPrimGroupListForm)
  {* ������ ������������� }
 end;//TPrimGroupListOptionsForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimGroupListOptionsForm);
 {* ����������� PrimGroupListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.

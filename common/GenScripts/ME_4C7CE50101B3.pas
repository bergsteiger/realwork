unit PrimUserListOptions_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimUserListOptions_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimUserListOptions" MUID: (4C7CE50101B3)
// ��� ����: "TPrimUserListOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimUserList_Form
;

type
 TPrimUserListOptionsForm = class(TPrimUserListForm)
 end;//TPrimUserListOptionsForm
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
 TtfwClassRef.Register(TPrimUserListOptionsForm);
 {* ����������� PrimUserListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.

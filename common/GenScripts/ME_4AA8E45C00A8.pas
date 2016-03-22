unit UserList_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\UserList_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "UserList" MUID: (4AA8E45C00A8)
// ��� ����: "TefUserList"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimUserListOptions_Form
 , Admin_FormDefinitions_Controls
;

type
 TefUserList = {final} class(TPrimUserListOptionsForm, UserListFormDef)
 end;//TefUserList
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , UserListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefUserList);
 {* ����������� UserList }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efUserList.SetFactory(TefUserList.Make);
 {* ����������� ������� ����� UserList }
{$IfEnd} // Defined(Admin)

end.

unit ContactList_Form;
 {* ��������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\ContactList_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "ContactList" MUID: (4A6971D00157)
// ��� ����: "TContactListForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimContactListOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_ContactListForm: TvcmFormDescriptor = (rFormID : (rName : 'ContactListForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TContactListForm }

type
 TContactListForm = class;

 ContactListFormDef = interface
  {* ������������� ����� ContactList }
  ['{D9641B68-E586-4058-B9BC-9E246E9D0455}']
 end;//ContactListFormDef

 TContactListForm = {final} class(TPrimContactListOptionsForm, ContactListFormDef)
  {* ��������� ������ }
 end;//TContactListForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ContactListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TContactListForm);
 {* ����������� ContactList }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ContactListForm.SetFactory(TContactListForm.Make);
 {* ����������� ������� ����� ContactList }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

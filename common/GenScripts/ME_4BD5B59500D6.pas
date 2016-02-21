unit PrimContactList_chatContacts_UserType;
 {* ��������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactList_chatContacts_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� chatContacts }
 chatContactsName = 'chatContacts';
  {* ��������� ������������� ����������������� ���� "��������� ������" }
 chatContacts = TvcmUserType(0);
  {* ��������� ������ }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_chatContacts = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� chatContacts }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_chatContacts
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_chatContacts.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::chatContacts';
end;//Tkw_FormUserType_chatContacts.GetWordNameForRegister

function Tkw_FormUserType_chatContacts.GetInteger: Integer;
begin
 Result := chatContacts;
end;//Tkw_FormUserType_chatContacts.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_chatContacts.RegisterInEngine;
 {* ����������� Tkw_FormUserType_chatContacts }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

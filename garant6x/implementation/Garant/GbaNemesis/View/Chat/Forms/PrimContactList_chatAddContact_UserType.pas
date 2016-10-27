unit PrimContactList_chatAddContact_UserType;
 {* �������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactList_chatAddContact_UserType.pas"
// ���������: "UserType"
// ������� ������: "chatAddContact" MUID: (4BD5B5C8019F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimContactList_chatContacts_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ chatAddContactLocalConstants }
 str_chatAddContactCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'chatAddContactCaption'; rValue : '�������� �������');
  {* ��������� ����������������� ���� "�������� �������" }
 {* ��������� ��� ���� ����� chatAddContact }
 chatAddContactName = 'chatAddContact';
  {* ��������� ������������� ����������������� ���� "�������� �������" }
 chatAddContact = TvcmUserType(chatContacts + 1);
  {* �������� ������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_chatAddContact = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� chatAddContact }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_chatAddContact
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_chatAddContact.GetInteger: Integer;
begin
 Result := chatAddContact;
end;//Tkw_FormUserType_chatAddContact.GetInteger

class function Tkw_FormUserType_chatAddContact.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::chatAddContact';
end;//Tkw_FormUserType_chatAddContact.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_chatAddContactCaption.Init;
 {* ������������� str_chatAddContactCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_chatAddContact.RegisterInEngine;
 {* ����������� Tkw_FormUserType_chatAddContact }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

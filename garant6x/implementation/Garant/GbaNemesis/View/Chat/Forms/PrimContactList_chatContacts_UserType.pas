unit PrimContactList_chatContacts_UserType;
 {* ��������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactList_chatContacts_UserType.pas"
// ���������: "UserType"
// ������� ������: "chatContacts" MUID: (4BD5B59500D6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ chatContactsLocalConstants }
 str_chatContactsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'chatContactsCaption'; rValue : '��������� ������');
  {* ��������� ����������������� ���� "��������� ������" }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_chatContacts = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� chatContacts }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_chatContacts
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_chatContacts.GetInteger: Integer;
begin
 Result := chatContacts;
end;//Tkw_FormUserType_chatContacts.GetInteger

class function Tkw_FormUserType_chatContacts.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::chatContacts';
end;//Tkw_FormUserType_chatContacts.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_chatContactsCaption.Init;
 {* ������������� str_chatContactsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_chatContacts.RegisterInEngine;
 {* ����������� Tkw_FormUserType_chatContacts }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

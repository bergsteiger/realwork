unit PrimContactList_chatAddContact_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/Forms/PrimContactList_chatAddContact_UserType.pas"
// �����: 01.10.2009 2:05
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������� ��������::Chat::View::Chat::PrimContactList::chatAddContact
//
// �������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimContactList_chatContacts_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� chatAddContact }
  chatAddContactName = 'chatAddContact';
   { ��������� ������������� ����������������� ���� "�������� �������" }
  chatAddContact = TvcmUserType(chatContacts + 1);
   { �������� ������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_chatAddContact = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� chatAddContact }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_chatAddContact
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_chatAddContact

class function Tkw_FormUserType_chatAddContact.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::chatAddContact';
end;//Tkw_FormUserType_chatAddContact.GetWordNameForRegister

function Tkw_FormUserType_chatAddContact.GetInteger: Integer;
 {-}
begin
 Result := chatAddContact;
end;//Tkw_FormUserType_chatAddContact.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_chatAddContact
 Tkw_FormUserType_chatAddContact.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.
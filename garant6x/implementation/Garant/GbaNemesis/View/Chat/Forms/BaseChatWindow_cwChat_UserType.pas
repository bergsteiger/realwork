unit BaseChatWindow_cwChat_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: �������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/Forms/BaseChatWindow_cwChat_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������� ��������::Chat::View::Chat::BaseChatWindow::cwChat
//
// ���������
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
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� cwChat }
  cwChatName = 'cwChat';
   { ��������� ������������� ����������������� ���� "���������" }
  cwChat = TvcmUserType(0);
   { ��������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_cwChat = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� cwChat }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_cwChat
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_cwChat

class function Tkw_FormUserType_cwChat.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::cwChat';
end;//Tkw_FormUserType_cwChat.GetWordNameForRegister

function Tkw_FormUserType_cwChat.GetInteger: Integer;
 {-}
begin
 Result := cwChat;
end;//Tkw_FormUserType_cwChat.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_cwChat
 Tkw_FormUserType_cwChat.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.
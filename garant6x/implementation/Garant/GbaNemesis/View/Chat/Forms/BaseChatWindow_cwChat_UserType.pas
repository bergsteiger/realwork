unit BaseChatWindow_cwChat_UserType;
 {* ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseChatWindow_cwChat_UserType.pas"
// ���������: "UserType"
// ������� ������: "cwChat" MUID: (4BD6D5500287)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ cwChatLocalConstants }
 str_cwChatCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cwChatCaption'; rValue : '���������');
  {* ��������� ����������������� ���� "���������" }
 {* ��������� ��� ���� ����� cwChat }
 cwChatName = 'cwChat';
  {* ��������� ������������� ����������������� ���� "���������" }
 cwChat = TvcmUserType(0);
  {* ��������� }
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
 Tkw_FormUserType_cwChat = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� cwChat }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_cwChat
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_cwChat.GetInteger: Integer;
begin
 Result := cwChat;
end;//Tkw_FormUserType_cwChat.GetInteger

class function Tkw_FormUserType_cwChat.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::cwChat';
end;//Tkw_FormUserType_cwChat.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_cwChatCaption.Init;
 {* ������������� str_cwChatCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cwChat.RegisterInEngine;
 {* ����������� Tkw_FormUserType_cwChat }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

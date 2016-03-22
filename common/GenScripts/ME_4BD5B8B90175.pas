unit BaseHistoryWindow_utChatHistory_UserType;
 {* ������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseHistoryWindow_utChatHistory_UserType.pas"
// ���������: "UserType"
// ������� ������: "utChatHistory" MUID: (4BD5B8B90175)

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
 {* ��������� ��� ���� ����� utChatHistory }
 utChatHistoryName = 'utChatHistory';
  {* ��������� ������������� ����������������� ���� "������� ���������" }
 utChatHistory = TvcmUserType(0);
  {* ������� ��������� }
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
 Tkw_FormUserType_utChatHistory = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utChatHistory }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utChatHistory
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utChatHistory.GetInteger: Integer;
begin
 Result := utChatHistory;
end;//Tkw_FormUserType_utChatHistory.GetInteger

class function Tkw_FormUserType_utChatHistory.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utChatHistory';
end;//Tkw_FormUserType_utChatHistory.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utChatHistory.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utChatHistory }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

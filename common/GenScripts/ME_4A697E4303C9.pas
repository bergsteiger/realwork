unit moChat;
 {* ��� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moChat.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Chat" MUID: (4A697E4303C9)
// ��� ����: "Tmo_Chat"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseChat_Module
;

type
 Tmo_Chat = {final} class(TBaseChatModule)
  {* ��� }
 end;//Tmo_Chat
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

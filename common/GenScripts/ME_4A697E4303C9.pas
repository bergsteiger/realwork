unit moChat;
 {* Чат }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moChat.pas"
// Стереотип: "VCMUseCaseRealization"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseChat_Module
;

type
 Tmo_Chat = {final} class(TBaseChatModule)
  {* Чат }
 end;//Tmo_Chat
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

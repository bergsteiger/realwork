unit nsChatWindowList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsChatWindowList.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsBaseChatWindowList
 , ChatTypes
 , l3Types
;

type
 _AbstactChatWindowList_Parent_ = TnsBaseChatWindowList;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Chat\AbstactChatWindowList.imp.pas}
 TnsChatWindowList = class(_AbstactChatWindowList_)
 end;//TnsChatWindowList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type _Instance_R_ = TnsChatWindowList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Chat\AbstactChatWindowList.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

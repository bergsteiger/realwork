unit nsChatHistoryList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsChatHistoryList.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsBaseChatHistoryList
 , ChatTypes
 , l3Types
;

type
 _AbstactChatWindowList_Parent_ = TnsBaseChatHistoryList;
 {$Include AbstactChatWindowList.imp.pas}
 TnsChatHistoryList = class(_AbstactChatWindowList_)
 end;//TnsChatHistoryList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type _Instance_R_ = TnsChatHistoryList;

{$Include AbstactChatWindowList.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

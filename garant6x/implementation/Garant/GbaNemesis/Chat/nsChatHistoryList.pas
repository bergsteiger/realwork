unit nsChatHistoryList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsChatHistoryList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsChatHistoryList" MUID: (4A6EAAEC023C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Chat\AbstactChatWindowList.imp.pas}
 TnsChatHistoryList = class(_AbstactChatWindowList_)
 end;//TnsChatHistoryList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , ChatInterfaces
 , l3Memory
 //#UC START# *4A6EAAEC023Cimpl_uses*
 //#UC END# *4A6EAAEC023Cimpl_uses*
;

type _Instance_R_ = TnsChatHistoryList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Chat\AbstactChatWindowList.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

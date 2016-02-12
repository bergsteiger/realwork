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
;

{$If not Declared(_ItemType_)}type _ItemType_ = IbsChatHistoryWindow;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

type _Instance_R_ = TnsChatHistoryList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Chat\AbstactChatWindowList.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

unit nsChatWindowList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Chat"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Chat/nsChatWindowList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Chat::Chat::ChatImpl::TnsChatWindowList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsBaseChatWindowList,
  ChatTypes,
  l3Types
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _AbstactChatWindowList_Parent_ = TnsBaseChatWindowList;
 {$Include ..\Chat\AbstactChatWindowList.imp.pas}
 TnsChatWindowList = class(_AbstactChatWindowList_)
 end;//TnsChatWindowList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TnsChatWindowList;

{$Include ..\Chat\AbstactChatWindowList.imp.pas}


{$IfEnd} //not Admin AND not Monitorings
end.
unit nsChatMessages;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Chat"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Chat/nsChatMessages.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Chat::Chat::ChatImpl::TnsChatMessages
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
  l3SimpleDataContainer,
  ChatInterfaces,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _ItemType_ = InsChatMessage;
 _l3InterfaceRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnsChatMessages = class(_l3InterfaceRefList_, InsChatMessages)
 protected
 // realized methods
   function Get_MessagesCount: Integer;
   function Get_Message(anIndex: Integer): InsChatMessage;
 end;//TnsChatMessages
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TnsChatMessages;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

// start class TnsChatMessages

function TnsChatMessages.Get_MessagesCount: Integer;
//#UC START# *4A66DDD60130_4A66F04303C3get_var*
//#UC END# *4A66DDD60130_4A66F04303C3get_var*
begin
//#UC START# *4A66DDD60130_4A66F04303C3get_impl*
 Result := Count;
//#UC END# *4A66DDD60130_4A66F04303C3get_impl*
end;//TnsChatMessages.Get_MessagesCount

function TnsChatMessages.Get_Message(anIndex: Integer): InsChatMessage;
//#UC START# *4A66DDE10034_4A66F04303C3get_var*
//#UC END# *4A66DDE10034_4A66F04303C3get_var*
begin
//#UC START# *4A66DDE10034_4A66F04303C3get_impl*
 Result := Items[anIndex];
//#UC END# *4A66DDE10034_4A66F04303C3get_impl*
end;//TnsChatMessages.Get_Message

{$IfEnd} //not Admin AND not Monitorings

end.
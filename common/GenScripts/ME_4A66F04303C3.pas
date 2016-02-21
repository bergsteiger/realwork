unit nsChatMessages;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsChatMessages.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleDataContainer
 , ChatInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InsChatMessage;
 _l3InterfaceRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnsChatMessages = class(_l3InterfaceRefList_, InsChatMessages)
  protected
   function Get_MessagesCount: Integer;
   function Get_Message(anIndex: Integer): InsChatMessage;
 end;//TnsChatMessages
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

type _Instance_R_ = TnsChatMessages;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

unit InsConfigNotifyRecipientPtrList;
 {* Список УКАЗАТЕЛЕЙ на InsConfigNotifyRecipient }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Settings\InsConfigNotifyRecipientPtrList.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , bsInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InsConfigNotifyRecipient;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfacePtrList.imp.pas}
 TInsConfigNotifyRecipientPtrList = class(_l3InterfacePtrList_)
  {* Список УКАЗАТЕЛЕЙ на InsConfigNotifyRecipient }
 end;//TInsConfigNotifyRecipientPtrList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TInsConfigNotifyRecipientPtrList;

{$Include l3InterfacePtrList.imp.pas}

end.

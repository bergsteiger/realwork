unit InsConfigNotifyRecipientPtrList;
 {* Список УКАЗАТЕЛЕЙ на InsConfigNotifyRecipient }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Settings\InsConfigNotifyRecipientPtrList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TInsConfigNotifyRecipientPtrList" MUID: (491450C80113)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
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
 //#UC START# *491450C80113impl_uses*
 //#UC END# *491450C80113impl_uses*
;

type _Instance_R_ = TInsConfigNotifyRecipientPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.

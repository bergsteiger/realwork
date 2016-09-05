unit daProgressSubscriberList;

// Модуль: "w:\common\components\rtl\Garant\DA\daProgressSubscriberList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaProgressSubscriberList" MUID: (552514FD0144)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , daInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IdaProgressSubscriber;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TdaProgressSubscriberList = class(_l3InterfacePtrList_)
 end;//TdaProgressSubscriberList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *552514FD0144impl_uses*
 //#UC END# *552514FD0144impl_uses*
;

type _Instance_R_ = TdaProgressSubscriberList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.

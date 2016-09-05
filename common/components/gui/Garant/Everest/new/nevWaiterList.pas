unit nevWaiterList;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevWaiterList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevWaiterList" MUID: (47ED17150259)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InevWaiter;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnevWaiterList = class(_l3InterfaceRefList_)
 end;//TnevWaiterList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *47ED17150259impl_uses*
 //#UC END# *47ED17150259impl_uses*
;

type _Instance_R_ = TnevWaiterList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.

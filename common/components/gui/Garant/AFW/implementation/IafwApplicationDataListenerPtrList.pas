unit IafwApplicationDataListenerPtrList;
 {* Список УКАЗАТЕЛЕЙ на IafwApplicationDataListener }

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\IafwApplicationDataListenerPtrList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TIafwApplicationDataListenerPtrList" MUID: (49143C860391)

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , afwInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IafwApplicationDataListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TIafwApplicationDataListenerPtrList = class(_l3InterfacePtrList_)
  {* Список УКАЗАТЕЛЕЙ на IafwApplicationDataListener }
 end;//TIafwApplicationDataListenerPtrList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *49143C860391impl_uses*
 //#UC END# *49143C860391impl_uses*
;

type _Instance_R_ = TIafwApplicationDataListenerPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.

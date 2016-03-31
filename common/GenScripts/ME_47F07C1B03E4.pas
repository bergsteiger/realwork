unit l3NotifyPtrList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3NotifyPtrList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3NotifyPtrList" MUID: (47F07C1B03E4)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3DataContainerWithoutIUnknownPrim
 , l3Interfaces
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , Classes
 //#UC START# *47F07C1B03E4intf_uses*
 //#UC END# *47F07C1B03E4intf_uses*
;

type
 //#UC START# *47F07C1B03E4ci*
 {$Define l3Items_NoChanging}
 {.$Define l3Items_NoSort}
 {$Define l3Items_NoOwner}
 //#UC END# *47F07C1B03E4ci*
 _ItemType_ = Il3Notify;
 _l3InterfacePtrList_Parent_ = Tl3DataContainerWithoutIUnknownPrim;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 //#UC START# *47F07C1B03E4cit*
 //#UC END# *47F07C1B03E4cit*
 Tl3NotifyPtrList = class(_l3InterfacePtrList_)
 //#UC START# *47F07C1B03E4publ*
 //#UC END# *47F07C1B03E4publ*
 end;//Tl3NotifyPtrList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , l3IID
 , l3InterfacesMisc
 //#UC START# *47F07C1B03E4impl_uses*
 //#UC END# *47F07C1B03E4impl_uses*
;

type _Instance_R_ = Tl3NotifyPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

//#UC START# *47F07C1B03E4impl*
//#UC END# *47F07C1B03E4impl*

end.

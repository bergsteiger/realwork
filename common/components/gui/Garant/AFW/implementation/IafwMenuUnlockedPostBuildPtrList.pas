unit IafwMenuUnlockedPostBuildPtrList;

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\IafwMenuUnlockedPostBuildPtrList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TIafwMenuUnlockedPostBuildPtrList" MUID: (4B0529C501F5)

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
 _ItemType_ = IafwMenuUnlockedPostBuild;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TIafwMenuUnlockedPostBuildPtrList = class(_l3InterfacePtrList_)
 end;//TIafwMenuUnlockedPostBuildPtrList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4B0529C501F5impl_uses*
 //#UC END# *4B0529C501F5impl_uses*
;

type _Instance_R_ = TIafwMenuUnlockedPostBuildPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.

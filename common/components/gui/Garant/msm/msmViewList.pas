unit msmViewList;

// Модуль: "w:\common\components\gui\Garant\msm\msmViewList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmViewList" MUID: (57B420A601C7)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , msmControllers
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TmsmView;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TmsmViewList = class(_l3ObjectPtrList_)
 end;//TmsmViewList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57B420A601C7impl_uses*
 //#UC END# *57B420A601C7impl_uses*
;

type _Instance_R_ = TmsmViewList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

end.

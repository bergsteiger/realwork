unit msmEventList;

// Модуль: "w:\common\components\gui\Garant\msm\msmEventList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmEventList" MUID: (57B59F9102A4)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , msmEvents
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TmsmEvent;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TmsmEventList = class(_l3ObjectPtrList_)
 end;//TmsmEventList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57B59F9102A4impl_uses*
 //#UC END# *57B59F9102A4impl_uses*
;

type _Instance_R_ = TmsmEventList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

end.

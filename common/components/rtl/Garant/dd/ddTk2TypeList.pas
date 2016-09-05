unit ddTk2TypeList;

// Модуль: "w:\common\components\rtl\Garant\dd\ddTk2TypeList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddTk2TypeList" MUID: (55DEEAFF0079)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , k2Base
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tk2Type;
 _l3NotSortedObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3NotSortedObjectRefList.imp.pas}
 TddTk2TypeList = class(_l3NotSortedObjectRefList_)
 end;//TddTk2TypeList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *55DEEAFF0079impl_uses*
 //#UC END# *55DEEAFF0079impl_uses*
;

type _Instance_R_ = TddTk2TypeList;

{$Include w:\common\components\rtl\Garant\L3\l3NotSortedObjectRefList.imp.pas}

end.

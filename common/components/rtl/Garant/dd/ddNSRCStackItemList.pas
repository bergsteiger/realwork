unit ddNSRCStackItemList;

// ������: "w:\common\components\rtl\Garant\dd\ddNSRCStackItemList.pas"
// ���������: "SimpleClass"
// ������� ������: "TddNSRCStackItemList" MUID: (55DC85CA02E3)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddNSRCSegments
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TddNSRCStackItem;
 _l3NotSortedObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3NotSortedObjectRefList.imp.pas}
 TddNSRCStackItemList = class(_l3NotSortedObjectRefList_)
 end;//TddNSRCStackItemList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *55DC85CA02E3impl_uses*
 //#UC END# *55DC85CA02E3impl_uses*
;

type _Instance_R_ = TddNSRCStackItemList;

{$Include w:\common\components\rtl\Garant\L3\l3NotSortedObjectRefList.imp.pas}

end.

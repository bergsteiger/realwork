unit ddTk2TypeList;

// ������: "w:\common\components\rtl\Garant\dd\ddTk2TypeList.pas"
// ���������: "SimpleClass"

{$Include ddDefine.inc}

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
 {$Include l3NotSortedObjectRefList.imp.pas}
 TddTk2TypeList = class(_l3NotSortedObjectRefList_)
 end;//TddTk2TypeList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TddTk2TypeList;

{$Include l3NotSortedObjectRefList.imp.pas}

end.

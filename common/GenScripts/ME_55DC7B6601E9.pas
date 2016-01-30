unit segTargetList;

// Модуль: "w:\common\components\rtl\Garant\dd\segTargetList.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , segTarget
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TsegTarget;
 _l3NotSortedObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3NotSortedObjectRefList.imp.pas}
 TsegTargetList = class(_l3NotSortedObjectRefList_)
 end;//TsegTargetList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TsegTargetList;

{$Include l3NotSortedObjectRefList.imp.pas}

end.

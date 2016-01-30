unit segObjectList;

// Модуль: "w:\common\components\rtl\Garant\dd\segObjectList.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

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
 _ItemType_ = TsegObject;
 _l3NotSortedObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3NotSortedObjectRefList.imp.pas}
 TsegObjectList = class(_l3NotSortedObjectRefList_)
 end;//TsegObjectList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TsegObjectList;

{$Include l3NotSortedObjectRefList.imp.pas}

end.

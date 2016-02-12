unit ddJustList;

// Модуль: "w:\common\components\rtl\Garant\dd\ddJustList.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , ddTypes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TJust;
 _l3EnumList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3EnumList.imp.pas}
 TddJustList = class(_l3EnumList_)
 end;//TddJustList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

type _Instance_R_ = TddJustList;

{$Include w:\common\components\rtl\Garant\L3\l3EnumList.imp.pas}

end.

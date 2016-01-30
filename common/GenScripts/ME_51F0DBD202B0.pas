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
 {$Include l3EnumList.imp.pas}
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

type _Instance_R_ = TddJustList;

{$Include l3EnumList.imp.pas}

end.

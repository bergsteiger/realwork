unit l3ByteList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ByteList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ByteList" MUID: (5372344A03CA)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Byte;
 _l3AtomicList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3AtomicList.imp.pas}
 Tl3ByteList = class(_l3AtomicList_)
 end;//Tl3ByteList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *5372344A03CAimpl_uses*
 //#UC END# *5372344A03CAimpl_uses*
;

type _Instance_R_ = Tl3ByteList;

{$Include w:\common\components\rtl\Garant\L3\l3AtomicList.imp.pas}

end.

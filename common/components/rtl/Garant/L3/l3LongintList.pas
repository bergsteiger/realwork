unit l3LongintList;
 {* Список целых чисел }

// Модуль: "w:\common\components\rtl\Garant\L3\l3LongintList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3LongintListPrim
;

type
 _ListType_ = Tl3LongintListPrim;
 _l3ListOperations_Parent_ = Tl3LongintListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3ListOperations.imp.pas}
 Tl3LongintList = class(_l3ListOperations_)
  {* Список целых чисел }
 end;//Tl3LongintList

implementation

uses
 l3ImplUses
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = Integer;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

{$Include w:\common\components\rtl\Garant\L3\l3ListOperations.imp.pas}

end.

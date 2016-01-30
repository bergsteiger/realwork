unit NOT_FINISHED_l3FieldSortRecList;

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3FieldSortRecList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3RecList
 , l3Types
;

type
 Tl3FieldSortRecList = class(Tl3RecList)
  private
   f_FieldSize: TSmallIntArray;
   f_FieldOffs: TLongArray;
   f_SortFields: TSmallIntArray;
 end;//Tl3FieldSortRecList

implementation

uses
 l3ImplUses
 , m2MemLib
;

end.

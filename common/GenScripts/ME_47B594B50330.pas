unit l3StandardTypedList.imp;

interface

uses
 l3IntfUses
 , l3Memory
 , l3Types
;

type
 _l3StandardTypedList_ = class(_l3FourByteItemList_)
  {* Стандартный типизированный список с размером элемента в 4 байта }
  procedure MakeSorted(aDuplicates: Tl3Duplicates;
   aSortIndex: Tl3SortIndex);
   {* Создает сортированный список }
  procedure Make;
 end;//_l3StandardTypedList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

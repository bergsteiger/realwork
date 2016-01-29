unit k2TypesByHandleList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , k2Base
;

 {$Define l3Items_NoSort}
 
type
 Tk2TypesByHandleList = class(_l3UnrefcountedList_)
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tk2TypesByHandleList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

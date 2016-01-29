unit tfwSortedDictionaryList.imp;

interface

uses
 l3IntfUses
;

type
 _tfwSortedDictionaryList_ = class(_tfwDictionaryListPrim_)
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//_tfwSortedDictionaryList_
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Types
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

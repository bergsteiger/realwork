unit tfwDictionaryList.imp;

interface

uses
 l3IntfUses
;

 {$Define l3Items_NoSort}
 
type
 _tfwDictionaryList_ = class(_tfwDictionaryListPrim_)
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//_tfwDictionaryList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

unit l3RevertedAtomicList.imp;

interface

uses
 l3IntfUses
;

type
 _l3RevertedAtomicList_ = class(_l3AtomicListPrim_)
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//_l3RevertedAtomicList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

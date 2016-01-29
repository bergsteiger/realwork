unit k2AtomicTagRefListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , k2AtomicTag
;

type
 Tk2AtomicTagRefListPrim = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tk2AtomicTagRefListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

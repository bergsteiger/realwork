unit l3ObjectWithHandleRefListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3ProtoObjectWithHandle
;

type
 Tl3ObjectWithHandleRefListPrim = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tl3ObjectWithHandleRefListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

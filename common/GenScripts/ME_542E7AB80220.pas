unit m3StorageHolderListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , m3StorageHolder
;

type
 Tm3StorageHolderListPrim = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tm3StorageHolderListPrim
 
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

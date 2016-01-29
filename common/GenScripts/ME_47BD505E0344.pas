unit k2ChildrenPathListPrim;

interface

uses
 l3IntfUses
 , l3DataContainerWithoutIUnknownPrim
 , k2ChildrenPath
;

type
 Tk2ChildrenPathListPrim = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tk2ChildrenPathListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

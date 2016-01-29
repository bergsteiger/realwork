unit evSubPanelSubCollectionPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , evSubPanelSubArray
 , Controls
;

type
 TevSubPanelSubCollectionPrim = class(_l3UncomparabeObjectRefList_)
  procedure Create(anOwner: TWinControl);
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TevSubPanelSubCollectionPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

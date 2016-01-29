unit evSubPanelSubArrayPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , Controls
 , l3Types
 , evSubPanelSub
;

 {$Define l3Items_FreeItem_NeedsList}
 
type
 TevSubPanelSubArrayPrim = class(_l3ObjectRefListPrim_)
  procedure Create(anOwner: TWinControl;
   aHandle: Tl3Handle);
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* Заполняет элемент списка. }
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* Очищает элемент списка }
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TevSubPanelSubArrayPrim
 
implementation

uses
 l3ImplUses
 , evSubPanelTools
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

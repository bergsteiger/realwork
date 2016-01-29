unit vgObjectList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vgObject
;

type
 TvgObjectList = class(_l3PtrList_)
  {* Списсок указателей на объект. НИЧЕГО не освобождает }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TvgObjectList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

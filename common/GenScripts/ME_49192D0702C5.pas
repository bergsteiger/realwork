unit nevSectionBreakListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
;

type
 TnevSectionBreakListPrim = class(_l3InterfaceRefListPrim_)
  {* Базовый список разрывов разделов }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TnevSectionBreakListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

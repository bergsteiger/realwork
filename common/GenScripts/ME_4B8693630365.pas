unit nevShapePrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

 {$Define l3Items_NoChanging}
 
 {$Define l3Items_NoSort}
 
type
 TnevShapePrim = class(_l3ObjectRefListPrim_)
  {* ���������� �� ������������ ������� }
  procedure CleanupRefs;
   {* ������� ������ �� ��������� ������� }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* ��������� ������� ������. }
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* ������� ������� ������ }
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//TnevShapePrim
 
implementation

uses
 l3ImplUses
 , nevShapesPainted
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

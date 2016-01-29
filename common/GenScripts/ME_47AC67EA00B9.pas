unit k2TagListPrim;

interface

uses
 l3IntfUses
 , k2ListTag
;

 {$Define l3Items_HasCustomSort}
 
 {$Define l3Items_NeedsAssignItem}
 
type
 Tk2TagListPrim = class(Tk2ListTag)
  {* ������ �����. }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//Tk2TagListPrim
 
implementation

uses
 l3ImplUses
 , k2BaseTypes
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.

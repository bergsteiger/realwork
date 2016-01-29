unit vcmCommandIDsListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

type
 TvcmCommandInfo = object
  {* ���������� � ������� }
 end;//TvcmCommandInfo
 
 TvcmCommandIDsListPrim = class(Tl3ProtoDataContainer)
  {* ������ ���������� � �������� }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//TvcmCommandIDsListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

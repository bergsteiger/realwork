unit nevObjectList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
;

type
 TnevObjectList = class(_l3InterfaceRefListPrim_)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* ���������� �������� ������ }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//TnevObjectList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.

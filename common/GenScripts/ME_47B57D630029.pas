unit l3InterfacePtrList.imp;

interface

uses
 l3IntfUses
;

type
 _l3InterfacePtrList_ = class(_l3InterfacePtrListPrim_)
  {* ������ ���������� �� ����������. }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* ���������� �������� ������ }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//_l3InterfacePtrList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
